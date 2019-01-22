within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Subsequences;
block FailsafeCondition
  "Failsafe condition used in staging up and down"

  parameter Modelica.SIunits.Time delayStaCha = 15*60
  "Enable delay";

  parameter Modelica.SIunits.TemperatureDifference temOffset = 1
  "Offset between the chilled water supply temperature and its setpoint";

  parameter Modelica.SIunits.PressureDifference dpOffset = 2 * 6895
  "Offset between the chilled water pump differential static pressure and its setpoint";

  CDL.Interfaces.RealInput uOplrUp(final unit="1")
    "Operating part load ratio of the next higher stage"
    annotation (Placement(transformation(extent={{-180,80},{-140,120}}),
        iconTransformation(extent={{-120,70},{-100,90}})));

  CDL.Interfaces.RealInput uOplrUpMin(final unit="1")
    "Minimum operating part load ratio at the next stage up"
    annotation (Placement(transformation(extent={{-180,40},{-140,80}}),
        iconTransformation(extent={{-120,30},{-100,50}})));

  CDL.Interfaces.RealInput dpChiWatPumSet(
    final unit="Pa",
    final quantity="PressureDifference")
    "Chilled water pump differential static pressure setpoint"
    annotation (Placement(transformation(extent={{-180,-100},{-140,-60}}),
      iconTransformation(extent={{-120,-80},{-100,-60}})));

  CDL.Interfaces.RealInput dpChiWatPum(
    final unit="Pa",
    final quantity="PressureDifference")
    "Chilled water pump differential static pressure"
    annotation (Placement(
    transformation(extent={{-180,-140},{-140,-100}}), iconTransformation(
     extent={{-120,-100},{-100,-80}})));

  CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-180,-20},{-140,20}}),
    iconTransformation(extent={{-120,-20},{-100,0}})));

  CDL.Interfaces.RealInput TChiWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water return temperature"
    annotation (Placement(transformation(
      extent={{-180,-60},{-140,-20}}),   iconTransformation(extent={{-120,-40},{
            -100,-20}})));

  CDL.Interfaces.BooleanOutput y "Failsafe condition for chiller staging"
    annotation (Placement(transformation(extent={{140,-10},{160,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  CDL.Continuous.Hysteresis hysOplr(final uLow=0, final uHigh=0.05)
    "Checks if the operating part load ratio of the next stage up exceeds the required minimum"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));

  CDL.Continuous.Hysteresis hysdpSup(final uLow=-dpOffset, final uHigh=-
        dpOffset + dpOffset/4)
    "Chilled water pump differential pressure and its setpoint hysteresis"
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));

  CDL.Continuous.Hysteresis hysTSup(final uLow=temOffset, final uHigh=temOffset
         + 1)
    "Checks if the chilled water supply temperature is higher than its setpoint plus an offset"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));

  CDL.Logical.TrueDelay truDel3(
    final delayTime=delayStaCha) "Delays a true signal"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));

  CDL.Logical.Or or2 "Logical or"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));

  CDL.Logical.And and2 "Logical and"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  CDL.Continuous.Add add0(k1=-1, k2=1)
                                 "Adder for temperatures"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));

  CDL.Continuous.Add add1(k1=-1, k2=1)
                                 "Adder for differetial pressures"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));

  CDL.Continuous.Add add2(k2=-1) "Adder for operating part load ratios"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

equation
  connect(truDel3.u, or2.y)
    annotation (Line(points={{58,-10},{41,-10}}, color={255,0,255}));
  connect(hysOplr.y, and2.u1) annotation (Line(points={{-39,90},{10,90},{10,10},
          {90,10},{90,0},{98,0}}, color={255,0,255}));
  connect(truDel3.y, and2.u2) annotation (Line(points={{81,-10},{90,-10},{90,-8},
          {98,-8}}, color={255,0,255}));
  connect(add1.y, hysdpSup.u)
    annotation (Line(points={{-79,-90},{-62,-90}}, color={0,0,127}));
  connect(dpChiWatPumSet, add1.u1) annotation (Line(points={{-160,-80},{-120,-80},
          {-120,-84},{-102,-84}},   color={0,0,127}));
  connect(dpChiWatPum, add1.u2) annotation (Line(points={{-160,-120},{-120,-120},
          {-120,-96},{-102,-96}},   color={0,0,127}));
  connect(hysTSup.y, or2.u1)
    annotation (Line(points={{-39,-10},{18,-10}}, color={255,0,255}));
  connect(add0.y, hysTSup.u)
    annotation (Line(points={{-79,-10},{-62,-10}}, color={0,0,127}));
  connect(TChiWatSupSet, add0.u1) annotation (Line(points={{-160,0},{-120,0},{-120,
          -4},{-102,-4}},         color={0,0,127}));
  connect(TChiWatSup, add0.u2) annotation (Line(points={{-160,-40},{-120,-40},{-120,
          -16},{-102,-16}}, color={0,0,127}));
  connect(add2.y, hysOplr.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(uOplrUp, add2.u1) annotation (Line(points={{-160,100},{-120,100},{-120,
          96},{-102,96}},   color={0,0,127}));
  connect(uOplrUpMin, add2.u2) annotation (Line(points={{-160,60},{-120,60},{-120,
          84},{-102,84}},   color={0,0,127}));
  connect(and2.y, y)
    annotation (Line(points={{121,0},{150,0}}, color={255,0,255}));
  connect(hysdpSup.y, or2.u2) annotation (Line(points={{-39,-90},{10,-90},{10,
          -18},{18,-18}}, color={255,0,255}));
  annotation (defaultComponentName = "faiSafCon",
        Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name")}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-140,-140},{140,140}})),
Documentation(info="<html>
<p>
Failsafe condition used in staging up and down, according to 2019-01-07 RP 1711 Task 2 document, section 5.2.4.11.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 21, 2019, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end FailsafeCondition;
