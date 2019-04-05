within ;
model SingleZone "Model of a thermal zone"

  parameter Modelica.SIunits.Time samplePeriod(min=100*Modelica.Constants.eps, start=0.1) = 60
    "Sample period of component";

  parameter Modelica.SIunits.Volume Core_ZN_V = 3*4*3 "Volume";
  parameter Modelica.SIunits.Area Core_ZN_AFlo = 3*4 "Floor area";
  parameter Real Core_ZN_mSenFac = 1 "Factor for scaling sensible thermal mass of volume";

  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Core_ZN_T "Temperature of the zone air";
  input Real Core_ZN_X(min=0, final unit="1") "Water vapor mass fraction in kg water/kg dry air";
  input Real X "Water vapor mass fraction per total air mass of zone";
  input Modelica.SIunits.MassFlowRate Core_ZN_mInlets_flow
     "Sum of positive mass flow rates into the zone for all air inlets (including infiltration)";
  input Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Core_ZN_TAveInlet
    "Average of inlets medium temperatures carried by the mass flow rates";
  input Modelica.SIunits.HeatFlowRate Core_ZN_QGaiRad_flow
    "Radiative sensible heat gain added to the zone";
  input Real Core_ZN_xTest "Test";
  discrete output Real Core_ZN_yTest "Test";

  discrete output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC Core_ZN_TRad
    "Average radiative temperature in the room";
  discrete output Modelica.SIunits.HeatFlowRate Core_ZN_QConSen_flow
    "Convective sensible heat added to the zone";
  discrete output Modelica.SIunits.HeatFlowRate Core_ZN_QLat_flow
    "Latent heat gain added to the zone";
  discrete output Modelica.SIunits.HeatFlowRate Core_ZN_QPeo_flow
      "Heat gain due to people";

  discrete output Modelica.SIunits.Conversions.NonSIunits.Temperature_degC TCon(start=20) "Construction temperature (first order approximation)";

protected
  parameter Modelica.SIunits.Time startTime(fixed=false) "First sample time instant";
  parameter Modelica.SIunits.Area ACon = (2*6*6+4*6*2.7) "Surface area of constructions";
  parameter Modelica.SIunits.Conductance Ah = ACon * 8 "Conductance A*h for all surfaces";
  parameter Modelica.SIunits.HeatCapacity CCon = ACon*0.2*800*2000 "Heat capacity of constructions";


  output Boolean sampleTrigger "True, if sample time instant";
  output Boolean firstTrigger(start=false, fixed=true)
    "Rising edge signals first sample instant";

initial equation
  startTime = time;

equation
  sampleTrigger = sample(startTime, samplePeriod);

  when sampleTrigger then
    firstTrigger = time <= startTime + samplePeriod/2;
  end when;

  when {sampleTrigger, initial()} then
//    Modelica.Utilities.Streams.print("+++ In when clause at t = "
//      + String(time) + " with Core_ZN_T = " + String(Core_ZN_T));
/*
    if initial() then
      TCon = pre(TCon) + samplePeriod / CCon * (Core_ZN_QConSen_flow + Core_ZN_QGaiRad_flow);
    else
      TCon = pre(TCon);
    end if;
    */
    if initial() then
      Core_ZN_yTest = pre(Core_ZN_xTest);
      TCon = pre(Core_ZN_xTest) ;//+ samplePeriod / CCon * (Core_ZN_QConSen_flow + Core_ZN_QGaiRad_flow);
    else
      Core_ZN_yTest = pre(Core_ZN_xTest) + 1;
      TCon = pre(Core_ZN_xTest) + 1;
    end if;
    Core_ZN_TRad = TCon;
    Core_ZN_QConSen_flow = 1*Core_ZN_T;// fixme Ah * (Core_ZN_T-pre(TCon));
    Core_ZN_QLat_flow = 400;
    Core_ZN_QPeo_flow = 200;
  end when;

end SingleZone;