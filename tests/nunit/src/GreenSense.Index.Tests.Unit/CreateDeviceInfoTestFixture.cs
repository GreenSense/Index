﻿using System;
using NUnit.Framework;
using System.IO;
namespace GreenSense.Index.Tests.Unit
{
	[TestFixture(Category = "Unit")]
	public class CreateDeviceInfoTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateDeviceInfo()
		{
			Console.WriteLine("Testing create-garden-info.sh script");

			var scriptName = "create-device-info.sh";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			var deviceType = "monitor/SoilMoistureSensorCalibratedSerial";
			var deviceLabel = "Monitor1";
			var deviceName = "monitor1";
			var devicePort = "ttyUSB0";

			var arguments = deviceType + " " + deviceLabel + " " + deviceName + " " + devicePort;

			var command = "sh " + scriptName + " " + arguments;

			var starter = new ProcessStarter();

			Console.WriteLine("Running script...");

			starter.Start(command);

			var output = starter.Output;

			Console.WriteLine("Checking device info was created...");

			CheckDeviceInfoWasCreated(deviceType, deviceLabel, deviceName, devicePort);

			Console.WriteLine("Checking console output is correct...");

			var successfulText = "Device info created";

			Assert.IsTrue(output.Contains(successfulText), "Failed");

			Console.WriteLine("Test complete");
		}
	}
}