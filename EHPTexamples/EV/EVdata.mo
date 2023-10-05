within EHPTexamples.EV;
model EVdata "Simulates a very basic Electric Vehicle"
  import Modelica;
  extends Modelica.Icons.Example;
  EHPTlib.SupportModels.Miscellaneous.DragForce dragF(m = mass.m,
  rho(displayUnit = "kg/m3") = data.rho, S = data.S, fc = data.fc,
  Cx = data.Cx,  v(start=0, fixed=true))       annotation (
    Placement(visible = true, transformation(origin = {82, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = data.ratio,
  flange_b(  phi(start=0, fixed=true))) annotation (
    Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
    Placement(visible = true, transformation(extent = {{-82, 10}, {-62, 30}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(
    CycleFileName=Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/NEDC.txt"),
      extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic,
      yMax = 100000.0, k = data.kContr) annotation (
    Placement(visible = true, transformation(extent = {{-118, 10}, {-98, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = data.m) annotation (
    Placement(visible = true, transformation(extent = {{34, 10}, {54, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
    Placement(visible = true, transformation(origin = {60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(
     radius = data.radius) annotation (
    Placement(visible = true, transformation(extent = {{4, 10}, {24, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = data.J) annotation (
    Placement(visible = true, transformation(extent = {{-54, 10}, {-34, 30}}, rotation = 0)));
  VehicleData.Car data annotation (
    Placement(transformation(extent = {{30, 40}, {50, 60}})));
equation
  connect(mass.flange_b, dragF.flange) annotation (
    Line(points = {{54, 20}, {82, 20}, {82, -16}}, color = {0, 127, 0}));
  connect(velSens.flange, mass.flange_b) annotation (
    Line(points = {{60, 0}, {60, 20}, {54, 20}}, color = {0, 127, 0}));
  connect(driver.V, velSens.v) annotation (
    Line(points = {{-108, 8.8}, {-108, -36}, {60, -36}, {60, -21}}, color = {0, 0, 127}));
  connect(mass.flange_a, wheel.flangeT) annotation (
    Line(points = {{34, 20}, {24, 20}}, color = {0, 127, 0}));
  connect(inertia.flange_a, torque.flange) annotation (
    Line(points = {{-54, 20}, {-58, 20}, {-62, 20}}));
  connect(inertia.flange_b, gear.flange_a) annotation (
    Line(points = {{-34, 20}, {-24, 20}}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-4, 20}, {-4, 20}, {4, 20}}));
  connect(torque.tau, driver.tauRef) annotation (
    Line(points = {{-84, 20}, {-97, 20}}, color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html><head></head><body><p>Very basic introductory EV model, but with use of \"data\" record for car's parameters.</p>
</body></html>"),
    Diagram(coordinateSystem(extent = {{-120, -40}, {100, 60}}, preserveAspectRatio = false),
      graphics={  Rectangle(origin = {-6, 0}, lineColor = {28, 108, 200},
      pattern = LinePattern.Dash, extent = {{-84, 36}, {-24, 4}}), Text(origin = {-6, 0}, lineColor = {28, 108, 200}, pattern = LinePattern.Dash, extent = {{-82, 2}, {-26, -4}}, textString = "electric drive")}),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false,
      initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 0.0001, Interval = 0.1));
end EVdata;
