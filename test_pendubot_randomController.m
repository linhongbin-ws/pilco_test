%%
addpath(genpath('/home/ben/code/dw_foc'))
clear all; clc;
controller = pendubot_controller();
controller = controller.setTaskPlotter(false);
controller = controller.setTaskPrinter(true);
duration = 10;
controller.maxTor1 = 1.5;
controller.maxTor2 = 1;


controller.set_zeroTor();
controller = controller.start();
tic

rng(1)

global des_q1 des_dq1_fil des_q2 des_dq2_fil RecordCell
global desTor1 
des_q1 = pi-pi/2;
des_dq1_fil = 0;
des_q2 = pi-pi/2;
des_dq2_fil = 0;
i = 0

while (size(RecordCell{1},2) < duration / controller.dT_Measure)
    controller = controller.run();
    if i ~= size(RecordCell{1},2)
        i = size(RecordCell{1},2);
        desTor1 =  (rand-0.5) * 2 * controller.maxTor1;
    end
    %desTor1 = sign(tor1) * min(abs(tor1), obj.maxTor1);
    %desTor2 = sign(tor2) * min(abs(tor2), obj.maxTor2);
end
controller.set_zeroTor();
controller.stop();
controller.delete_controller();

toc


