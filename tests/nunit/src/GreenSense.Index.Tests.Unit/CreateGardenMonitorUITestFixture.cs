﻿using System;
using NUnit.Framework;
using System.IO;
using Newtonsoft.Json.Linq;
namespace GreenSense.Index.Tests.Unit
{
	[TestFixture(Category = "Unit")]
	public class CreateGardenMonitorUITestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateGardenMonitorUI()
		{
			var scriptName = "create-garden-monitor-ui.sh";

			Console.WriteLine("Testing " + scriptName + " script");

			var deviceLabel = "Monitor1";
			var deviceName = "monitor1";

			var arguments = deviceLabel + " " + deviceName;

			var command = "sh " + scriptName + " " + arguments;

			var starter = new ProcessStarter();

			Console.WriteLine("Running script...");

			starter.Start(command);

			var output = starter.Output;

			Console.WriteLine("Checking device UI was created...");

			CheckDeviceUIWasCreated(deviceLabel, deviceName, "Soil Moisture", "C");

			Console.WriteLine("Creating device info folder...");

			Directory.CreateDirectory(Path.GetFullPath("devices/" + deviceName));

			Console.WriteLine("Attempting to create a duplicate...");

			starter.Start(command);

			Console.WriteLine("Ensuring that no duplicate UI was created...");

			CheckDeviceUICount(1);
		}
	}
}
