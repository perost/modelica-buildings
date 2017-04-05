within Buildings.Experimental.OpenBuildingControl.CDL.Continuous;
block IntegratorWithReset "Output the integral of the input signal"

  Interfaces.RealInput u "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Interfaces.RealOutput y "Connector of Real output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  parameter Real k(unit="1")=1 "Integrator gain";

  /* InitialState is the default, because it was the default in Modelica 2.2
     and therefore this setting is backward compatible
  */
  parameter Types.Init initType=Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
    annotation(Evaluate=true,
      Dialog(group="Initialization"));

  parameter Real y_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));

  parameter Types.Reset reset = Types.Reset.Disabled
    "Type of integrator reset";

  parameter Real y_reset = 0
    "Value to which integrator is reset, used if reset = Types.Reset.Parameter"
    annotation(Evaluate=true,
               Dialog(
                 enable=reset == Buildings.Types.Reset.Parameter,
                 group="Integrator reset"));

  Interfaces.RealInput y_reset_in if
       reset == Types.Reset.Input
    "Input signal for state to which integrator is reset, enabled if reset = Types.Reset.Input"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));

  Interfaces.BooleanInput trigger if
       reset <> Types.Reset.Disabled
    "Resets the integrator output when trigger becomes true"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
protected
  Interfaces.RealInput y_reset_internal
   "Internal connector for integrator reset"
   annotation(Evaluate=true);

  Interfaces.BooleanInput trigger_internal
    "Needed to use conditional connector trigger";

initial equation
  if initType == Types.Init.SteadyState then
     der(y) = 0;
  elseif initType == Types.Init.InitialState or
         initType == Types.Init.InitialOutput then
    y = y_start;
  end if;

equation
  der(y) = k*u;

  // Equations for integrator reset
  connect(trigger, trigger_internal);
  connect(y_reset_in, y_reset_internal);

  if reset <> Types.Reset.Input then
    y_reset_internal = y_reset;
  end if;

  if reset == Types.Reset.Disabled then
    trigger_internal = false;
  else
    when trigger_internal then
      reinit(y, y_reset_internal);
    end when;
  end if;

  annotation (
defaultComponentName="intWitRes",
Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
        graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
          Text(
            extent={{-88,-94},{212,-54}},
          lineColor={0,0,0},
          textString="y_reset_in",
          visible= (reset == Types.Reset.Input),
          horizontalAlignment=TextAlignment.Left),
        Bitmap(extent={{-54,-50},{60,50}}, fileName=
              "modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/CDL/Continuous/int.png"),
          Text(
            extent={{-88,56},{206,92}},
          lineColor={0,0,0},
          textString="k=%k",
          horizontalAlignment=TextAlignment.Left),
          Text(
            extent={{-92,-12},{208,28}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="u"),
          Text(
            extent={{70,-14},{370,26}},
          lineColor={0,0,0},
          horizontalAlignment=TextAlignment.Left,
          textString="y")}),
    Documentation(info="<html>
<p>
This model is similar to
<a href=\"modelica://Modelica.Blocks.Continuous.Integrator\">
Modelica.Blocks.Continuous.Integrator</a>
except that it optionally allows to reset the output <code>y</code>
of the integrator.
</p>
<p>
The output of the integrator can be reset as follows:
</p>
<ul>
<li>
If <code>reset = Types.Reset.Disabled</code>, which is the default,
then the integrator is never reset.
</li>
<li>
If <code>reset = Types.Reset.Parameter</code>, then a boolean
input signal <code>trigger</code> is enabled. Whenever the value of
this input changes from <code>false</code> to <code>true</code>,
the integrator is reset by setting <code>y</code>
to the value of the parameter <code>y_reset</code>.
</li>
<li>
If <code>reset = Types.Reset.Input</code>, then a boolean
input signal <code>trigger</code> is enabled. Whenever the value of
this input changes from <code>false</code> to <code>true</code>,
the integrator is reset by setting <code>y</code>
to the value of the input signal <code>y_reset_in</code>.
</li>
</ul>
<h4>Implementation</h4>
<p>
To adjust the icon layer, the code of
<a href=\"modelica://Modelica.Blocks.Continuous.Integrator\">
Modelica.Blocks.Continuous.Integrator</a>
has been copied into this model rather than extended.
</p>
</html>", revisions="<html>
<ul>
<li>
March 23, 2017, by Jianjun Hu:<br/>
First implementation, based on the implementation of the
Modelica Standard Library.
</li>
</ul>
</html>"));
end IntegratorWithReset;