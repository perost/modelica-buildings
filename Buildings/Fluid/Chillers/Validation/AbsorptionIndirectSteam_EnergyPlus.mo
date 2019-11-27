within Buildings.Fluid.Chillers.Validation;
model AbsorptionIndirectSteam_EnergyPlus
  "Validation with EnergyPlus model"
 package Medium = Buildings.Media.Water "Medium model";

  Buildings.Fluid.Chillers.AbsorptionIndirectSteam absChi(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    per=per,
    allowFlowReversal1=true,
    allowFlowReversal2=true,
    m1_flow_nominal=mCon_flow_nominal,
    m2_flow_nominal=mEva_flow_nominal,
    show_T=true,
    dp1_nominal=0,
    dp2_nominal=0,
    tau1=30,
    tau2=30,
    homotopyInitialization=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T1_start=25 + 273.15,
    T2_start=10 + 273.15) "Absorption indirect chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  parameter Modelica.SIunits.MassFlowRate mEva_flow_nominal=per.mEva_flow_nominal
    "Evaporator nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate mCon_flow_nominal=per.mCon_flow_nominal
    "Condenser nominal mass flow rate";

  Sources.MassFlowSource_T conPum(
    use_m_flow_in=false,
      m_flow=mCon_flow_nominal,
      use_T_in=true,
      redeclare package Medium = Medium,
    nPorts=1)
    "Condenser water pump"
      annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-50,50})));
  Sources.MassFlowSource_T evaPum(
    use_m_flow_in=true,
      m_flow=mEva_flow_nominal,
      nPorts=1,
      use_T_in=true,
      redeclare package Medium = Medium)
    "Evaporator water pump"
      annotation (
      Placement(transformation(
        extent={{-12,-12},{12,12}},
        rotation=180,
        origin={40,-6})));
  Modelica.Fluid.Sources.FixedBoundary cooVol(
    redeclare package Medium = Medium, nPorts=1)
      "Volume for cooling load"
       annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Fluid.Sources.FixedBoundary heaVol(
    redeclare package Medium = Medium, nPorts=1)
      "Volume for heating load"
       annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Blocks.Sources.TimeTable TEvaEnt(
    table=[0,284; 600,284; 1200,284; 1800,284; 2400,284; 3000,284; 3600,284;
        4200,284; 4800,284; 5400,284; 6000,285; 6600,285; 7200,285; 7800,285;
        8400,283; 9000,282; 9600,285; 10200,284; 10800,284; 11400,283; 12000,
        283; 12600,283; 13200,283; 13800,283; 14400,283; 15000,283; 15600,283;
        16200,283; 16800,283; 17400,283; 18000,283; 18600,283; 19200,283; 19800,
        283; 20400,283; 21000,283; 21600,284; 22200,284; 22800,284; 23400,284;
        24000,284; 24600,284; 25200,284; 25800,284; 26400,284; 27000,284; 27600,
        284; 28200,284; 28800,284; 29400,284; 30000,284; 30600,284; 31200,284;
        31800,284; 32400,284; 33000,284; 33600,284; 34200,284; 34800,284; 35400,
        284; 36000,284; 36600,284; 37200,284; 37800,284; 38400,284; 39000,284;
        39600,284; 40200,284; 40800,284; 41400,284; 42000,284; 42600,284; 43200,
        284; 43800,284; 44400,284; 45000,284; 45600,284; 46200,284; 46800,284;
        47400,284; 48000,284; 48600,284; 49200,284; 49800,284; 50400,284; 51000,
        284; 51600,284; 52200,284; 52800,284; 53400,284; 54000,284; 54600,284;
        55200,284; 55800,284; 56400,284; 57000,284; 57600,284; 58200,284; 58800,
        284; 59400,284; 60000,284; 60600,284; 61200,284; 61800,284; 62400,284;
        63000,284; 63600,284; 64200,284; 64800,284; 65400,284; 66000,284; 66600,
        284; 67200,284; 67800,284; 68400,284; 69000,284; 69600,284; 70200,284],
        offset=0,startTime=0)
        "EnergyPlus entering water temperature at the evaporator"
         annotation (Placement(transformation(extent={{100,0},{80,20}})));
    Modelica.Blocks.Sources.TimeTable absChiMod(table=[0,0; 600,0; 1200,0; 1800,
        0; 2400,0; 3000,0; 3600,0; 4200,0; 4800,0; 5400,1; 6000,1; 6600,1; 7200,
        1; 7800,1; 8400,1; 9000,1; 9600,1; 10200,1; 10800,1; 11400,1; 12000,1;
        12600,1; 13200,1; 13800,1; 14400,1; 15000,1; 15600,1; 16200,1; 16800,1;
        17400,1; 18000,1; 18600,1; 19200,1; 19800,1; 20400,1; 21000,1; 21600,1;
        22200,1; 22800,1; 23400,1; 24000,1; 24600,1; 25200,1; 25800,1; 26400,1;
        27000,1; 27600,1; 28200,1; 28800,1; 29400,1; 30000,1; 30600,1; 31200,1;
        31800,1; 32400,1; 33000,1; 33600,1; 34200,1; 34800,1; 35400,1; 36000,1;
        36600,1; 37200,1; 37800,1; 38400,1; 39000,1; 39600,1; 40200,1; 40800,1;
        41400,1; 42000,1; 42600,0; 43200,0; 43800,0; 44400,0; 45000,0; 45600,0;
        46200,0; 46800,0; 47400,0; 48000,0; 48600,0; 49200,0; 49800,0; 50400,0;
        51000,0; 51600,0; 52200,0; 52800,0; 53400,0; 54000,0; 54600,0; 55200,0;
        55800,0; 56400,0; 57000,0; 57600,0; 58200,0; 58800,0; 59400,0; 60000,0;
        60600,0; 61200,0; 61800,0; 62400,0; 63000,0; 63600,0; 64200,0; 64800,0;
        65400,0; 66000,0; 66600,0; 67200,0; 67800,0; 68400,0; 69000,0; 69600,0;
        70200,0])
        "EnergyPlus absorption chiller mode control signal"
        annotation (Placement(transformation(extent={{-100,-8},{-80,12}})));
    Modelica.Blocks.Sources.TimeTable TEvaSet(
    table=[0,284; 600,284; 1200,284; 1800,284; 2400,284; 3000,284; 3600,284;
        4200,284; 4800,284; 5400,284; 6000,282.1; 6600,282.1; 7200,283; 7800,
        282.8; 8400,279.8; 9000,279.8; 9600,282.3; 10200,281.8; 10800,279.8;
        11400,279.8; 12000,279.8; 12600,279.8; 13200,279.8; 13800,279.8; 14400,
        279.8; 15000,279.8; 15600,279.8; 16200,279.8; 16800,279.8; 17400,279.8;
        18000,279.8; 18600,279.8; 19200,279.8; 19800,279.8; 20400,279.8; 21000,
        279.8; 21600,279.8; 22200,279.8; 22800,279.8; 23400,279.8; 24000,279.8;
        24600,279.8; 25200,279.8; 25800,279.8; 26400,279.8; 27000,279.8; 27600,
        279.8; 28200,279.8; 28800,279.8; 29400,279.8; 30000,279.8; 30600,279.8;
        31200,279.8; 31800,279.8; 32400,279.8; 33000,279.8; 33600,279.8; 34200,
        279.8; 34800,279.8; 35400,279.8; 36000,279.8; 36600,279.8; 37200,279.8;
        37800,279.8; 38400,279.8; 39000,279.8; 39600,279.8; 40200,279.8; 40800,
        279.8; 41400,279.8; 42000,284; 42600,284; 43200,284; 43800,284; 44400,
        284; 45000,284; 45600,284; 46200,284; 46800,284; 47400,284; 48000,284;
        48600,284; 49200,284; 49800,284; 50400,284; 51000,284; 51600,284; 52200,
        284; 52800,284; 53400,284; 54000,284; 54600,284; 55200,284; 55800,284;
        56400,284; 57000,284; 57600,284; 58200,284; 58800,284; 59400,284; 60000,
        284; 60600,284; 61200,284; 61800,284; 62400,284; 63000,284; 63600,284;
        64200,284; 64800,284; 65400,284; 66000,284; 66600,284; 67200,284; 67800,
        284; 68400,284; 69000,284; 69600,284; 70200,284],
        offset=0,
        startTime=0)
        "EnergyPlus leaving water temperature at the evaporator"
         annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
    Modelica.Blocks.Sources.TimeTable QEvaEP(table=[0,0; 600,0; 1200,0; 1800,0;
        2400,0; 3000,0; 3600,0; 4200,0; 4800,0; 5400,0; 6000,-4098; 6600,-3982;
        7200,-1839; 7800,-3101; 8400,-4971; 9000,-3517; 9600,-3260; 10200,-3432;
        10800,-6082; 11400,-5349; 12000,-5352; 12600,-5365; 13200,-5372; 13800,
        -5378; 14400,-5385; 15000,-5394; 15600,-5403; 16200,-5413; 16800,-5424;
        17400,-5437; 18000,-5450; 18600,-5503; 19200,-5521; 19800,-5571; 20400,
        -5590; 21000,-5643; 21600,-5663; 22200,-5721; 22800,-5743; 23400,-5803;
        24000,-5825; 24600,-5824; 25200,-5825; 25800,-5836; 26400,-5852; 27000,
        -5905; 27600,-5924; 28200,-6002; 28800,-6086; 29400,-6155; 30000,-6210;
        30600,-6228; 31200,-6281; 31800,-6300; 32400,-6348; 33000,-6366; 33600,
        -6378; 34200,-6427; 34800,-6444; 35400,-6453; 36000,-6495; 36600,-6504;
        37200,-6508; 37800,-6515; 38400,-6521; 39000,-6503; 39600,-6482; 40200,
        -6468; 40800,-6459; 41400,-6450; 42000,0; 42600,0; 43200,0; 43800,0;
        44400,0; 45000,0; 45600,0; 46200,0; 46800,0; 47400,0; 48000,0; 48600,0;
        49200,0; 49800,0; 50400,0; 51000,0; 51600,0; 52200,0; 52800,0; 53400,0;
        54000,0; 54600,0; 55200,0; 55800,0; 56400,0; 57000,0; 57600,0; 58200,0;
        58800,0; 59400,0; 60000,0; 60600,0; 61200,0; 61800,0; 62400,0; 63000,0;
        63600,0; 64200,0; 64800,0; 65400,0; 66000,0; 66600,0; 67200,0; 67800,0;
        68400,0; 69000,0; 69600,0; 70200,0])
    "EnergyPlus heat flow at the evaporator"
         annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
    Modelica.Blocks.Sources.TimeTable QConEP(table=[0,0; 600,0; 1200,0; 1800,0;
        2400,0; 3000,0; 3600,0; 4200,0; 4800,0; 5400,0; 6000,11417.2; 6600,
        11098.5; 7200,5227; 7800,8646; 8400,13907; 9000,10053.5; 9600,9091.3;
        10200,9601.1; 10800,16957; 11400,14947.7; 12000,14955.7; 12600,14991.4;
        13200,15010.1; 13800,15025.4; 14400,15042.8; 15000,15067.7; 15600,
        15092.6; 16200,15119; 16800,15147.6; 17400,15183.7; 18000,15220.4;
        18600,15364.7; 19200,15413.4; 19800,15550.9; 20400,15602.9; 21000,
        15749.9; 21600,15805; 22200,15965.2; 22800,16024.3; 23400,16189.6;
        24000,16250.3; 24600,16246.9; 25200,16249.3; 25800,16279.2; 26400,16323;
        27000,16470.7; 27600,16522.4; 28200,16738.1; 28800,16969.9; 29400,17159;
        30000,17311.6; 30600,17361; 31200,17506.7; 31800,17560.5; 32400,17691.6;
        33000,17743.9; 33600,17776.7; 34200,17912.6; 34800,17960; 35400,17983.2;
        36000,18100.6; 36600,18125.5; 37200,18134.7; 37800,18155.9; 38400,
        18171.1; 39000,18121.4; 39600,18063; 40200,18025.3; 40800,17999.6;
        41400,17976.2; 42000,0; 42600,0; 43200,0; 43800,0; 44400,0; 45000,0;
        45600,0; 46200,0; 46800,0; 47400,0; 48000,0; 48600,0; 49200,0; 49800,0;
        50400,0; 51000,0; 51600,0; 52200,0; 52800,0; 53400,0; 54000,0; 54600,0;
        55200,0; 55800,0; 56400,0; 57000,0; 57600,0; 58200,0; 58800,0; 59400,0;
        60000,0; 60600,0; 61200,0; 61800,0; 62400,0; 63000,0; 63600,0; 64200,0;
        64800,0; 65400,0; 66000,0; 66600,0; 67200,0; 67800,0; 68400,0; 69000,0;
        69600,0; 70200,0])
        "EnergyPlus heat flow at the condenser  "
        annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
    Modelica.Blocks.Sources.TimeTable QGenEP(table=[0,0; 600,0; 1200,0; 1800,0;
        2400,0; 3000,0; 3600,0; 4200,0; 4800,0; 5400,0; 6000,7229; 6600,7031;
        7200,3313; 7800,5470; 8400,8786; 9000,6387; 9600,5756; 10200,6069;
        10800,10725; 11400,9448; 12000,9453; 12600,9476; 13200,9488; 13800,9497;
        14400,9508; 15000,9524; 15600,9539; 16200,9556; 16800,9574; 17400,9597;
        18000,9620; 18600,9712; 19200,9743; 19800,9830; 20400,9863; 21000,9957;
        21600,9992; 22200,10094; 22800,10131; 23400,10236; 24000,10275; 24600,
        10273; 25200,10275; 25800,10293; 26400,10321; 27000,10415; 27600,10448;
        28200,10586; 28800,10734; 29400,10854; 30000,10952; 30600,10983; 31200,
        11076; 31800,11110; 32400,11194; 33000,11227; 33600,11248; 34200,11335;
        34800,11365; 35400,11380; 36000,11455; 36600,11471; 37200,11477; 37800,
        11491; 38400,11500; 39000,11469; 39600,11431; 40200,11407; 40800,11391;
        41400,11376; 42000,0; 42600,0; 43200,0; 43800,0; 44400,0; 45000,0;
        45600,0; 46200,0; 46800,0; 47400,0; 48000,0; 48600,0; 49200,0; 49800,0;
        50400,0; 51000,0; 51600,0; 52200,0; 52800,0; 53400,0; 54000,0; 54600,0;
        55200,0; 55800,0; 56400,0; 57000,0; 57600,0; 58200,0; 58800,0; 59400,0;
        60000,0; 60600,0; 61200,0; 61800,0; 62400,0; 63000,0; 63600,0; 64200,0;
        64800,0; 65400,0; 66000,0; 66600,0; 67200,0; 67800,0; 68400,0; 69000,0;
        69600,0; 70200,0])
    "EnergyPlus heat flow at the generator "
    annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));
    Modelica.Blocks.Math.RealToBoolean realToBoolean(threshold=1)
    "Real to boolean conversion for control input"
         annotation (Placement(transformation(extent={{-60,12},{-40,-8}})));
    Modelica.Blocks.Sources.TimeTable TConEnt(table=[0,297.93; 600,297.93; 1200,
        297.93; 1800,297.93; 2400,297.93; 3000,297.93; 3600,297.93; 4200,297.93;
        4800,297.93; 5400,297.93; 6000,297.71; 6600,296.29; 7200,295.44; 7800,
        295.96; 8400,296.05; 9000,296.12; 9600,295.57; 10200,296.61; 10800,
        296.79; 11400,297.03; 12000,296.99; 12600,297; 13200,296.98; 13800,
        296.93; 14400,296.87; 15000,296.83; 15600,296.76; 16200,296.68; 16800,
        296.65; 17400,296.68; 18000,296.69; 18600,296.71; 19200,296.77; 19800,
        296.78; 20400,296.87; 21000,296.93; 21600,296.99; 22200,297.04; 22800,
        297.06; 23400,297.06; 24000,297.07; 24600,297.1; 25200,297.08; 25800,
        297.05; 26400,297.03; 27000,297.01; 27600,297.07; 28200,297.16; 28800,
        297.32; 29400,297.48; 30000,297.61; 30600,297.71; 31200,297.73; 31800,
        297.7; 32400,297.65; 33000,297.61; 33600,297.55; 34200,297.5; 34800,
        297.48; 35400,297.47; 36000,297.45; 36600,297.45; 37200,297.43; 37800,
        297.42; 38400,297.45; 39000,297.51; 39600,297.56; 40200,297.61; 40800,
        297.65; 41400,297.7; 42000,297.93; 42600,297.93; 43200,297.93; 43800,
        297.93; 44400,297.93; 45000,297.93; 45600,297.93; 46200,297.93; 46800,
        297.93; 47400,297.93; 48000,297.93; 48600,297.93; 49200,297.93; 49800,
        297.93; 50400,297.93; 51000,297.93; 51600,297.93; 52200,297.93; 52800,
        297.93; 53400,297.93; 54000,297.93; 54600,297.93; 55200,297.93; 55800,
        297.93; 56400,297.93; 57000,297.93; 57600,297.93; 58200,297.93; 58800,
        297.93; 59400,297.93; 60000,297.93; 60600,297.93; 61200,297.93; 61800,
        297.93; 62400,297.93; 63000,297.93; 63600,297.93; 64200,297.93; 64800,
        297.93; 65400,297.93; 66000,297.93; 66600,297.93; 67200,297.93; 67800,
        297.93; 68400,297.93; 69000,297.93; 69600,297.93; 70200,297.93],
        offset=0)
    "EnergyPlus entering water temperature at the condenser"
          annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
    Modelica.Blocks.Sources.TimeTable mEva_flow(table=[0,0; 600,0; 1200,0; 1800,
        0; 2400,0; 3000,0; 3600,0; 4200,0; 4800,0; 5400,0; 6000,0.21; 6600,0.19;
        7200,0.14; 7800,0.18; 8400,0.37; 9000,0.33; 9600,0.17; 10200,0.24;
        10800,0.37; 11400,0.37; 12000,0.37; 12600,0.37; 13200,0.37; 13800,0.37;
        14400,0.37; 15000,0.37; 15600,0.37; 16200,0.37; 16800,0.37; 17400,0.37;
        18000,0.37; 18600,0.37; 19200,0.37; 19800,0.37; 20400,0.37; 21000,0.37;
        21600,0.37; 22200,0.37; 22800,0.37; 23400,0.37; 24000,0.37; 24600,0.37;
        25200,0.37; 25800,0.37; 26400,0.37; 27000,0.37; 27600,0.37; 28200,0.37;
        28800,0.37; 29400,0.37; 30000,0.37; 30600,0.37; 31200,0.37; 31800,0.37;
        32400,0.37; 33000,0.37; 33600,0.37; 34200,0.37; 34800,0.37; 35400,0.37;
        36000,0.37; 36600,0.37; 37200,0.37; 37800,0.37; 38400,0.37; 39000,0.37;
        39600,0.37; 40200,0.37; 40800,0.37; 41400,0.37; 42000,0; 42600,0; 43200,
        0; 43800,0; 44400,0; 45000,0; 45600,0; 46200,0; 46800,0; 47400,0; 48000,
        0; 48600,0; 49200,0; 49800,0; 50400,0; 51000,0; 51600,0; 52200,0; 52800,
        0; 53400,0; 54000,0; 54600,0; 55200,0; 55800,0; 56400,0; 57000,0; 57600,
        0; 58200,0; 58800,0; 59400,0; 60000,0; 60600,0; 61200,0; 61800,0; 62400,
        0; 63000,0; 63600,0; 64200,0; 64800,0; 65400,0; 66000,0; 66600,0; 67200,
        0; 67800,0; 68400,0; 69000,0; 69600,0; 70200,0],
        offset=0)
    "EnergyPlus entering water flow rate at the evaporator"
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  parameter Data.AbsorptionIndirectSteam.EnergyPlusValidation per
    "Chiller performance data"
    annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
equation
  connect(evaPum.ports[1], absChi.port_a2) annotation (Line(points={{28,-6},{10,
          -6}},                  color={0,127,255}));
  connect(TEvaSet.y, absChi.TSet) annotation (Line(points={{-79,-80},{-16,-80},{
          -16,-2},{-11,-2}},
                        color={0,0,127}));
  connect(absChiMod.y, realToBoolean.u)
    annotation (Line(points={{-79,2},{-62,2}}, color={0,0,127}));
  connect(absChi.on, realToBoolean.y) annotation (Line(points={{-11,2},{-39,2}},
                               color={255,0,255}));
  connect(conPum.T_in, TConEnt.y) annotation (Line(points={{-62,46},{-79,46}},
                              color={0,0,127}));
  connect(evaPum.T_in, TEvaEnt.y) annotation (Line(points={{54.4,-10.8},{68,
          -10.8},{68,10},{79,10}},
                               color={0,0,127}));
  connect(evaPum.m_flow_in, mEva_flow.y) annotation (Line(points={{54.4,-15.6},
          {68,-15.6},{68,-30},{79,-30}},  color={0,0,127}));
  connect(cooVol.ports[1], absChi.port_b2) annotation (Line(points={{-80,-50},{-20,
          -50},{-20,-6},{-10,-6}}, color={0,127,255}));
  connect(absChi.port_b1, heaVol.ports[1]) annotation (Line(points={{10,6},{20,
          6},{20,30},{40,30}},
                            color={0,127,255}));
  connect(conPum.ports[1], absChi.port_a1) annotation (Line(points={{-40,50},{-20,
          50},{-20,6},{-10,6}}, color={0,127,255}));
   annotation (Icon(coordinateSystem(preserveAspectRatio=false),       graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-102},{100,98}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-30,64},{70,4},{-30,-56},{-30,64}})}),
   Diagram(coordinateSystem(extent={{-160,-100},{120,100}})),
  __Dymola_Commands(file= "modelica://Buildings/Resources/Scripts/Dymola/Fluid/Chillers/Validation/AbsorptionIndirectSteam_EnergyPlus.mos"
        "Simulate and plot"),
    experiment(
      StopTime=70200,
      __Dymola_NumberOfIntervals=5000,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
  Documentation(info="<html>
<p>
This model validates the model
<a href=\"Buildings.Fluid.Chillers.AbsorptionIndirectSteam\">
Buildings.Fluid.Chillers.AbsorptionIndirectSteam</a>.
<p>
The EnergyPlus results were generated using the example file <code>IndirectAbsorptionChiller.idf</code>
from EnergyPlus 9.1, with a nominal cooling capacity of <i>10000</i> Watts.
</p>
</html>", revisions="<html>
<ul>
<li>
July 4, 2019, by Hagar Elarga:<br/>
First implementation.
</li>
</ul>
</html>"));
end AbsorptionIndirectSteam_EnergyPlus;
