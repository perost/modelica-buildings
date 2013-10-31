within Buildings.Electrical.Interfaces;
partial model PartialInductiveLoad "Partial model for an inductive load"
  extends PartialLoad;
  function j = PhaseSystem.j;
  parameter Real pf(min=0, max=1) = 0.8 "Power factor"  annotation(evaluate=true,Dialog(group="Nominal conditions"));
  Modelica.SIunits.MagneticFlux psi[2](each stateSelect=StateSelect.prefer);
  Modelica.SIunits.Impedance Z[2];
  Modelica.SIunits.AngularVelocity omega;
protected
  Modelica.SIunits.Power Q = P*tan(acos(pf));
  annotation (Documentation(revisions="<html>
<ul>
<li>
October 31, 2013, by Marco Bonvini:<br/>
Model included into the Buildings library.
</li>
</ul>
</html>"));
end PartialInductiveLoad;
