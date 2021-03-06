function recovered3DPoints = reconstruct3DFrom2D(cam1, cam1PixelCoords, cam2, cam2PixelCoords)

    recovered3DPoints = zeros(size(cam1PixelCoords));

    % set up variable to get viewing ray for cam1
    Rmat1 = cam1.Rmat;
    Rtranspose1 = transpose(Rmat1);
    Kmat1 = cam1.Kmat;
    Kinverse1 = inv(Kmat1);
    cam1position = cam1.position;
    cx1 = cam1position(1);
    cy1 = cam1position(2);
    cz1 = cam1position(3);

    t11 = -((cx1*Rmat1(1,1)) + (cy1*Rmat1(1,2)) + (cz1*Rmat1(1,3)));
    t12 = -((cx1*Rmat1(2,1)) + (cy1*Rmat1(2,2)) + (cz1*Rmat1(2,3)));
    t13 = -((cx1*Rmat1(3,1)) + (cy1*Rmat1(3,2)) + (cz1*Rmat1(3,3)));

    T1 = [t11; t12; t13];

    % set up variables to get viewing ray for cam2
    Rmat2 = cam2.Rmat;
    Rtranspose2 = transpose(Rmat2);
    Kmat2 = cam2.Kmat;
    Kinverse2 = inv(Kmat2);
    cam2position = cam2.position;
    cx2 = cam2position(1);
    cy2 = cam2position(2);
    cz2 = cam2position(3);

    t21 = -((cx2*Rmat2(1,1)) + (cy2*Rmat2(1,2)) + (cz2*Rmat2(1,3)));
    t22 = -((cx2*Rmat2(2,1)) + (cy2*Rmat2(2,2)) + (cz2*Rmat2(2,3)));
    t23 = -((cx2*Rmat2(3,1)) + (cy2*Rmat2(3,2)) + (cz2*Rmat2(3,3)));

    T2 = [t21; t22; t23];

    for i=1:12
        Pu1 = [cam1PixelCoords(1,i); cam1PixelCoords(2,i); cam1PixelCoords(3,i)];
        V1 = Rtranspose1 * Kinverse1 * Pu1;
        C1 = Rtranspose1 * T1;
        Pw1 = V1 + C1; %viewing ray
        VUnit1 = V1 ./ norm(V1);

        Pu2 = [cam2PixelCoords(1,i); cam2PixelCoords(2,i); cam2PixelCoords(3,i)];
        V2 = Rtranspose2 * Kinverse2 * Pu2;
        C2 = Rtranspose2 * T2;
        Pw2 = V2 + C2;
        VUnit2 = V2 ./ norm(V2);

        % use unit vectors to get third unit vector
        V3Cross = cross(VUnit1, VUnit2);
        VUnit3 =  V3Cross / norm(V3Cross);

        % solve for a, b, and d
        A = [VUnit1(1) -VUnit2(1) VUnit3(1);...
            VUnit1(2) -VUnit2(2) VUnit3(2);...
            VUnit1(3) -VUnit2(3) VUnit3(3)];

        b = [C2(1)-C1(1); C2(2)-C1(2); C2(3)-C1(3)];

        x = A\b;
        a = x(1);
        b = x(2);
        d = x(3);

        % use a, b, and d to find points. Then find the midpoint of the two points.
        % the midpoint is the answer.
        p1 = C1 + a*VUnit1;
        p2 = C2 + b*VUnit2;
        p = (p1 + p2) / 2;

        recovered3DPoints(1,i) = -p(1);
        recovered3DPoints(2,i) = -p(2);
        recovered3DPoints(3,i) = -p(3);
        
    end
end