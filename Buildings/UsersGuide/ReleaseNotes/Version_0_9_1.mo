within Buildings.UsersGuide.ReleaseNotes;

class Version_0_9_1 "Version 0.9.1"
  extends Modelica.Icons.ReleaseNotes;
  annotation(preferredView = "info", Documentation(info = "<html>
  <p>
  The following <b style=\"color:red\">critical error</b> has been fixed (i.e. error
  that can lead to wrong simulation results):
  </p>

  <table class=\"releaseTable\" summary=\"summary\" border=\"1\" cellspacing=0 cellpadding=2 style=\"border-collapse:collapse;\">
    <tr><td colspan=\"2\"><b>Buildings.Fluid.Storage.</b></td></tr>
    <tr><td valign=\"top\"><a href=\"modelica://Buildings.Fluid.Storage.StratifiedEnhanced\">
    Buildings.Fluid.Storage.StratifiedEnhanced</a></td>
        <td valign=\"top\">The model <code>Buildings.Fluid.Storage.BaseClasses.Stratifier</code>
        had a sign error that lead to a wrong energy balance.
        The model that was affected by this error is
        <a href=\"modelica://Buildings.Fluid.Storage.StratifiedEnhanced\">
        Buildings.Fluid.Storage.StratifiedEnhanced</a>.
        The model 
        <a href=\"modelica://Buildings.Fluid.Storage.Stratified\">
        Buildings.Fluid.Storage.Stratified</a> was not affected.<br/>
        The bug has been fixed by using the newly introduced model
        <a href=\"modelica://Buildings.Fluid.Storage.BaseClasses.ThirdOrderStratifier\">
          Buildings.Fluid.Storage.BaseClasses.ThirdOrderStratifier</a>. This model
        uses a third-order upwind scheme to reduce the numerical dissipation instead of the
        correction term that was used in <code>Buildings.Fluid.Storage.BaseClasses.Stratifier</code>.
        The model <code>Buildings.Fluid.Storage.BaseClasses.Stratifier</code> has been removed since it
        also led to significant overshoot in temperatures when the stratification was pronounced.
        </td>
    </tr>
  </table>
  </html>
  "));
end Version_0_9_1;