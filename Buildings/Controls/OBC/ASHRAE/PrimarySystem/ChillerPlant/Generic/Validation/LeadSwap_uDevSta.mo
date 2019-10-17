within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.Validation;
model LeadSwap_uDevSta
  "Validation sequence for enabling and disabling chiller plant"

  parameter Modelica.SIunits.Temperature aveTWetBul = 288.15
    "Chilled water supply set temperature";

  EquipmentRotationLeadSwap equRot
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  CDL.Logical.Sources.Pulse booPul(width=0.5, period=10)
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  CDL.Logical.Sources.Pulse booPul1(
    width=0.5,
    period=12,
    startTime=0)
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
equation

  connect(booPul.y, equRot.uLeaStaSet[1]) annotation (Line(points={{-118,50},{
          -60,50},{-60,4},{-42,4}}, color={255,0,255}));
  connect(booPul.y, not1.u) annotation (Line(points={{-118,50},{-110,50},{-110,
          30},{-102,30}}, color={255,0,255}));
  connect(not1.y, equRot.uLeaStaSet[2]) annotation (Line(points={{-78,30},{-60,
          30},{-60,4},{-42,4}}, color={255,0,255}));
  connect(booPul.y, equRot.uDevSta[1]) annotation (Line(points={{-118,50},{-60,
          50},{-60,-4},{-42,-4}}, color={255,0,255}));
  connect(booPul1.y, not2.u)
    annotation (Line(points={{-118,-10},{-102,-10}}, color={255,0,255}));
  connect(not2.y, equRot.uDevSta[2]) annotation (Line(points={{-78,-10},{-60,
          -10},{-60,-4},{-42,-4}}, color={255,0,255}));
annotation (
  experiment(StopTime=10, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Generic/Validation/PlantEnable.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.PlantEnable\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.PlantEnable</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 20, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
  graphics={Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-140},{200,140}})));
end LeadSwap_uDevSta;