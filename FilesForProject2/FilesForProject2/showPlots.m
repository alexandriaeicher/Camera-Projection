function [] = showPlots(mocapFnum, points2D2, points2D4, L1, L2)
    filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
    filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4.mp4';

    vue2Video = VideoReader(filenamevue2mp4);
    vue4Video = VideoReader(filenamevue4mp4);
    
    % plot points2D2 and points2D4 onto frame
    vue2Video.CurrentTime = (mocapFnum-1)*(50/100)/vue2Video.FrameRate;
    vid2Frame = readFrame(vue2Video);
    vue4Video.CurrentTime = (mocapFnum-1)*(50/100)/vue4Video.FrameRate;
    vid4Frame = readFrame(vue4Video);

    figure(mocapFnum);
    set(gcf, 'Position',  [100, 100, 1000, 600])

    subplot(2,2,1)
    title('vue2');
    image(vid2Frame);
    axis on;
    hold on;

    % plot 2D points for vue2
    for i=1:12
        plot(points2D2(1,i,:), points2D2(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 1, 'Color', 'r');
    end
    % plot skeleton for vue2
    rightShoulder1 = [points2D2(1,1,:); points2D2(2,1,:)];
    rightElbow1 = [points2D2(1,2,:); points2D2(2,2,:)];
    rightWrist1 = [points2D2(1,3,:); points2D2(2,3,:)];
    leftShoulder1 = [points2D2(1,4,:); points2D2(2,4,:)];
    leftElbow1 = [points2D2(1,5,:); points2D2(2,5,:)];
    leftWrist1 = [points2D2(1,6,:); points2D2(2,6,:)];
    rightHip1 = [points2D2(1,7,:); points2D2(2,7,:)];
    rightKnee1 = [points2D2(1,8,:); points2D2(2,8,:)];
    rightAnkle1 = [points2D2(1,9,:); points2D2(2,9,:)];
    leftHip1 = [points2D2(1,10,:); points2D2(2,10,:)];
    leftKnee1 = [points2D2(1,11,:); points2D2(2,11,:)];
    leftAnkle1 = [points2D2(1,12,:); points2D2(2,12,:)];

    % line between the right shoulder and right elbow
    plot([rightShoulder1(1), rightElbow1(1)], [rightShoulder1(2), rightElbow1(2)], 'LineWidth',1, 'Color','r');
    % line between the right elbow and right wrist
    plot([rightElbow1(1), rightWrist1(1)], [rightElbow1(2), rightWrist1(2)], 'LineWidth',1, 'Color','r')
    % line between the right shoulder and left shoulder
    plot([rightShoulder1(1), leftShoulder1(1)], [rightShoulder1(2), leftShoulder1(2)], 'LineWidth',1, 'Color','r');
    % line between the right hip and left hip
    plot([rightHip1(1), leftHip1(1)], [rightHip1(2), leftHip1(2)], 'LineWidth',1, 'Color','r');
    % line between the left shoulder and left elbow
    plot([leftShoulder1(1), leftElbow1(1)], [leftShoulder1(2), leftElbow1(2)], 'LineWidth',1, 'Color','r');
    % line between the left elbow and left wrist
    plot([leftElbow1(1), leftWrist1(1)], [leftElbow1(2), leftWrist1(2)], 'LineWidth',1, 'Color','r');
    % line between the right hip and right knee
    plot([rightHip1(1), rightKnee1(1)], [rightHip1(2), rightKnee1(2)], 'LineWidth',1, 'Color','r');
    % line between the right knee and right ankle
    plot([rightKnee1(1), rightAnkle1(1)], [rightKnee1(2), rightAnkle1(2)], 'LineWidth',1, 'Color','r');
    % line between the left hip and left knee
    plot([leftHip1(1), leftKnee1(1)], [leftHip1(2), leftKnee1(2)], 'LineWidth',1, 'Color','r');
    % line between the left knee and left ankle
    plot([leftKnee1(1), leftAnkle1(1)], [leftKnee1(2), leftAnkle1(2)], 'LineWidth',1, 'Color','r');
    % and a “spine” that connects the midpoint of the two shoulder joints
    % to the midpoint of the two hip joints.
    rightShoulderPoint1 = [rightShoulder1(1), rightShoulder1(2)];
    leftShoulderPoint1 = [leftShoulder1(1), leftShoulder1(2)];
    shoulderMidpoint1 = (rightShoulderPoint1(:) + leftShoulderPoint1(:)).'/2;

    rightHipPoint1 = [rightHip1(1), rightHip1(2)];
    leftHipPoint1 = [leftHip1(1), leftHip1(2)];
    hipMidpoint1 = (rightHipPoint1(:) + leftHipPoint1(:)) .'/2;

    plot([shoulderMidpoint1(1), hipMidpoint1(1)], [shoulderMidpoint1(2), hipMidpoint1(2)], 'LineWidth',1, 'Color','r');
    figure1text = 'Skeleton for frame ' + string(mocapFnum) + ' of vue2 camera';
    title(figure1text);
    subplot(2,2,2);
    image(vid4Frame);
    axis on;
    hold on;
    for i=1:12
        plot(points2D4(1,i,:), points2D4(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 2, 'Color', 'b');
    end
    % plot skeleton for vue2
    rightShoulder2 = [points2D4(1,1,:); points2D4(2,1,:)];
    rightElbow2 = [points2D4(1,2,:); points2D4(2,2,:)];
    rightWrist2 = [points2D4(1,3,:); points2D4(2,3,:)];
    leftShoulder2 = [points2D4(1,4,:); points2D4(2,4,:)];
    leftElbow2 = [points2D4(1,5,:); points2D4(2,5,:)];
    leftWrist2 = [points2D4(1,6,:); points2D4(2,6,:)];
    rightHip2 = [points2D4(1,7,:); points2D4(2,7,:)];
    rightKnee2 = [points2D4(1,8,:); points2D4(2,8,:)];
    rightAnkle2 = [points2D4(1,9,:); points2D4(2,9,:)];
    leftHip2 = [points2D4(1,10,:); points2D4(2,10,:)];
    leftKnee2 = [points2D4(1,11,:); points2D4(2,11,:)];
    leftAnkle2 = [points2D4(1,12,:); points2D4(2,12,:)];

    % line between the right shoulder and right elbow
    plot([rightShoulder2(1), rightElbow2(1)], [rightShoulder2(2), rightElbow2(2)], 'LineWidth',1, 'Color','b');
    % line between the right elbow and right wrist
    plot([rightElbow2(1), rightWrist2(1)], [rightElbow2(2), rightWrist2(2)], 'LineWidth',1, 'Color','b')
    % line between the right shoulder and left shoulder
    plot([rightShoulder2(1), leftShoulder2(1)], [rightShoulder2(2), leftShoulder2(2)], 'LineWidth',1, 'Color','b');
    % line between the right hip and left hip
    plot([rightHip2(1), leftHip2(1)], [rightHip2(2), leftHip2(2)], 'LineWidth',1, 'Color','b');
    % line between the left shoulder and left elbow
    plot([leftShoulder2(1), leftElbow2(1)], [leftShoulder2(2), leftElbow2(2)], 'LineWidth',1, 'Color','b');
    % line between the left elbow and left wrist
    plot([leftElbow2(1), leftWrist2(1)], [leftElbow2(2), leftWrist2(2)], 'LineWidth',1, 'Color','b');
    % line between the right hip and right knee
    plot([rightHip2(1), rightKnee2(1)], [rightHip2(2), rightKnee2(2)], 'LineWidth',1, 'Color','b');
    % line between the right knee and right ankle
    plot([rightKnee2(1), rightAnkle2(1)], [rightKnee2(2), rightAnkle2(2)], 'LineWidth',1, 'Color','b');
    % line between the left hip and left knee
    plot([leftHip2(1), leftKnee2(1)], [leftHip2(2), leftKnee2(2)], 'LineWidth',1, 'Color','b');
    % line between the left knee and left ankle
    plot([leftKnee2(1), leftAnkle2(1)], [leftKnee2(2), leftAnkle2(2)], 'LineWidth',1, 'Color','b');
    % and a “spine” that connects the midpoint of the two shoulder joints
    % to the midpoint of the two hip joints.
    rightShoulderPoint2 = [rightShoulder2(1), rightShoulder2(2)];
    leftShoulderPoint2 = [leftShoulder2(1), leftShoulder2(2)];
    shoulderMidpoint2 = (rightShoulderPoint2(:) + leftShoulderPoint2(:)).'/2;

    rightHipPoint2 = [rightHip2(1), rightHip2(2)];
    leftHipPoint2 = [leftHip2(1), leftHip2(2)];
    hipMidpoint2 = (rightHipPoint2(:) + leftHipPoint2(:)) .'/2;

    plot([shoulderMidpoint2(1), hipMidpoint2(1)], [shoulderMidpoint2(2), hipMidpoint2(2)], 'LineWidth',1, 'Color','b');
    figure2text = 'Skeleton for frame ' + string(mocapFnum) + ' of vue4 camera';
    title(figure2text);


    % epipolar lines plotted
    colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

    %plot epipolar lines over image
    [nr,nc,nb] = size(vid4Frame);
    subplot(2,2,3)
    image(vid2Frame);

    for i=1:length(L2)
       a = L2(1,i); b = L2(2,i); c=L2(3,i);
       if (abs(a) > (abs(b)))
          ylo=0; yhi=nr; 
          xlo = (-b * ylo - c) / a;
          xhi = (-b * yhi - c) / a;
          hold on
          h=plot([xlo; xhi],[ylo; yhi]);
          set(h,'Color',colors(i),'LineWidth',2);
          plot(points2D2(1,i,:), points2D2(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 2);
          hold off
          drawnow;
       else
          xlo=0; xhi=nc; 
          ylo = (-a * xlo - c) / b;
          yhi = (-a * xhi - c) / b;
          hold on
          h=plot([xlo; xhi],[ylo; yhi], 'b');
          set(h,'Color',colors(i),'LineWidth',2);
          plot(points2D2(1,i,:), points2D2(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 2);
          hold off
          drawnow;
       end
    end
    figure3text = 'Epipolar lines for frame ' + string(mocapFnum) + ' of vue2 camera';
    title(figure3text);

    %epipolar lines for camera 2
    %L = F * [x2; y2; ones(size(x2))];
    [nr,nc,nb] = size(vid2Frame);
    subplot(2,2,4)
            title('vue4');
            image(vid4Frame);

    for i=1:length(L1)
       a = L1(1,i); b = L1(2,i); c=L1(3,i);
       if (abs(a) > (abs(b)))
          ylo=0; yhi=nr; 
          xlo = (-b * ylo - c) / a;
          xhi = (-b * yhi - c) / a;
          hold on
          plot(points2D4(1,i,:), points2D4(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 2);
          h=plot([xlo; xhi],[ylo; yhi],'b');
          set(h,'Color',colors(i),'LineWidth',2);

          hold off
          drawnow;
       else
          xlo=0; xhi=nc; 
          ylo = (-a * xlo - c) / b;
          yhi = (-a * xhi - c) / b;
          hold on
          h=plot([xlo; xhi],[ylo; yhi],'b');
          plot(points2D4(1,i,:), points2D4(2,i,:), '.', 'MarkerSize', 15, 'LineWidth', 2);
          set(h,'Color',colors(i),'LineWidth',2);
          hold off
          drawnow;
       end
       figure4text = 'Epipolar lines for frame ' + string(mocapFnum) + ' of vue4 camera';
       title(figure4text);

    end
end