function [R,MAPE,MAE,RMSE]=indexcal(YTrue, YSim)
R_1 = 1 - norm(YTrue(1,:) - YSim(1,:))^2 / norm(YTrue(1,:) - mean(YTrue(1,:)))^2;
R_2 = 1 - norm(YTrue(2,:) - YSim(2,:))^2 / norm(YTrue(2,:) - mean(YTrue(2,:)))^2;
R_3 = 1 - norm(YTrue(3,:) - YSim(3,:))^2 / norm(YTrue(3,:) - mean(YTrue(3,:)))^2;
R_4 = 1 - norm(YTrue(4,:) - YSim(4,:))^2 / norm(YTrue(4,:) - mean(YTrue(4,:)))^2;

MAPE1 = mape(YTrue(1,:),YSim(1,:));
MAPE2 = mape(YTrue(2,:),YSim(2,:));
MAPE3 = mape(YTrue(3,:),YSim(3,:));
MAPE4 = mape(YTrue(4,:),YSim(4,:));

MAE1 = mae(YTrue(1,:),YSim(1,:));
MAE2 = mae(YTrue(2,:),YSim(2,:));
MAE3 = mae(YTrue(3,:),YSim(3,:));
MAE4 = mae(YTrue(4,:),YSim(4,:));

RMSE1 = sqrt(mse(YTrue(1,:),YSim(1,:)));
RMSE2 = sqrt(mse(YTrue(2,:),YSim(2,:)));
RMSE3 = sqrt(mse(YTrue(3,:),YSim(3,:)));
RMSE4 = sqrt(mse(YTrue(4,:),YSim(4,:)));

R = [R_1,R_2,R_3,R_4];
MAPE = [MAPE1, MAPE2,MAPE3,MAPE4];
MAE = [MAE1, MAE2,MAE3,MAE4];
RMSE= [RMSE1,RMSE2,RMSE3,RMSE4];

end
