﻿using System;
using NUnit.Framework;

namespace GreenSense.Index.Tests.Integration
{
	[TestFixture(Category = "Integration")]
	public class CreateIrrigatorNanoTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateIrrigatorNanoScript()
		{
			var scriptName = "create-garden-irrigator-nano.sh";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			var deviceType = "irrigator/SoilMoistureSensorCalibratedPump";
			var deviceLabel = "MyIrrigator";
			var deviceName = "myIrrigator";
			var devicePort = "ttyUSB1";

			var arguments = deviceLabel + " " + deviceName + " " + devicePort;

			var starter = GetTestProcessStarter();
			starter.RunBash("sh " + scriptName + " " + arguments);

			CheckDeviceInfoWasCreated(deviceType, deviceLabel, deviceName, devicePort);

			CheckDeviceUIWasCreated(deviceLabel, deviceName, "Soil Moisture", "C");

			CheckMqttBridgeServiceFileWasCreated(deviceName);

			CheckUpdaterServiceFileWasCreated(deviceName);
		}
	}
}
