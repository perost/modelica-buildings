within Buildings.Fluid.Sensors.Examples;
model Density "Test model for the density sensor"
  extends Modelica.Icons.Example;
  import Buildings;

  package Medium = Buildings.Media.PerfectGases.MoistAirUnsaturated
    "Medium model";

  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    T=293.15,
    nPorts=1) "Flow boundary condition" annotation (Placement(
        transformation(extent={{90,-40},{70,-20}},
                                                 rotation=0)));
  Buildings.Fluid.Sources.MassFlowSource_T masFloRat(
    redeclare package Medium = Medium,
    use_T_in=false,
    X={0.02,0.98},
    nPorts=1,
    use_m_flow_in=true) "Flow boundary condition"
     annotation (Placement(transformation(
          extent={{-50,-10},{-30,10}},rotation=0)));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Buildings.Fluid.Sensors.Density senDenVol(
    redeclare package Medium = Medium) "Density sensor for the volume"
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium,
    V=1,
    nPorts=3,
    m_flow_nominal=10) "Volume"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Buildings.Fluid.FixedResistances.FixedResistanceDpM dp(
    redeclare package Medium = Medium,
    m_flow_nominal=10,
    dp_nominal=200) "Flow resistance"
    annotation (Placement(transformation(extent={{8,-40},{28,-20}})));
  Buildings.Fluid.Sensors.DensityTwoPort senDenFlo(
    redeclare package Medium = Medium,
    m_flow_nominal=10) "Density sensor for the flowing medium"
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=-20,
    offset=10,
    duration=60)
    annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
equation
  connect(masFloRat.ports[1], vol.ports[1]) annotation (Line(
      points={{-30,0},{-2.66667,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[2], dp.port_a) annotation (Line(
      points={{0,0},{0,-30},{8,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(vol.ports[3], senDenVol.port) annotation (Line(
      points={{2.66667,0},{30,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(dp.port_b, senDenFlo.port_a) annotation (Line(
      points={{28,-30},{40,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senDenFlo.port_b, sin.ports[1]) annotation (Line(
      points={{60,-30},{70,-30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(ramp.y, masFloRat.m_flow_in) annotation (Line(
      points={{-69,8},{-50,8}},
      color={0,0,127},
      smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
experiment(StopTime=60),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Sensors/Examples/Density.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This example tests the density sensors.
</p>
</html>", revisions="<html>
<ul>
<li>
August 31, 2013 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end Density;
