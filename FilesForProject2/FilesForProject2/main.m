function [] = main()
  
    load 'Subject4-Session3-Take4_mocapJoints.mat' mocapJoints
    load 'vue2CalibInfo.mat' vue2
    load 'vue4CalibInfo.mat' vue4

    minError = 1000;
    maxError = -1000;
    minErrorFrame = 1;
    maxErrorFrame = 1;

    %input and parsing of mocap dataset
    for mocapFnum = 22347:22347 %1:size(mocapJoints, 1)
        conf = mocapJoints(mocapFnum,:,4); %confidence values
        s = sum(conf); %sum should equal 12
        if s == 12
            x = mocapJoints(mocapFnum,:,1); %array of 12 X coordinates
            y = mocapJoints(mocapFnum,:,2); % Y coordinates
            z = mocapJoints(mocapFnum,:,3); % Z coordinates (joint coords)
            worldCoord3DPoints = [x;y;z];

            % project3DTo2D
            points2D2 = project3DTo2D(vue2, worldCoord3DPoints);
            points2D4 = project3DTo2D(vue4, worldCoord3DPoints);

            % recostruct3DFrom2D
            recovered3DPoints = reconstruct3DFrom2D(vue2, points2D2, vue4, points2D4);
            reconstructionError = measureError(worldCoord3DPoints, recovered3DPoints);
            if reconstructionError > maxError
                maxError = reconstructionError;
                maxErrorFrame = mocapFnum;
            end
            if reconstructionError < minError
                minError = reconstructionError;
                minErrorFrame = mocapFnum;
            end

            [L1, L2] = findEpipolarLines(worldCoord3DPoints, vue2, points2D2, vue4, points2D4);
            showPlots(mocapFnum, points2D2, points2D4, L1, L2);

        end %if
    end %for
end %main
