﻿using System;
using NUnit.Framework;
using System.IO;
using Newtonsoft.Json.Linq;
namespace GreenSense.Index.Tests.Unit
{
	[TestFixture(Category = "Unit")]
	public class CreateGardenVentilatorUITestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateGardenVentilatorUI()
		{
			var scriptName = "create-garden-ventilator-ui.sh";

			Console.WriteLine("Testing " + scriptName + " script");

			var deviceLabel = "Ventilator1";
			var deviceName = "ventilator1";

			var arguments = deviceLabel + " " + deviceName;

			var command = "sh " + scriptName + " " + arguments;

			var starter = new ProcessStarter();

			Console.WriteLine("Running script...");

			starter.Start(command);

			var output = starter.Output;

			Console.WriteLine("Checking device UI was created...");

			CheckDeviceUIWasCreated(deviceLabel, deviceName, "Ventilator1", "A", "Temperature", "T");

			Console.WriteLine("Creating device info folder...");

			Directory.CreateDirectory(Path.GetFullPath("devices/" + deviceName));

			Console.WriteLine("Attempting to create a duplicate...");

			starter.Start(command);

			Console.WriteLine("Ensuring that no duplicate UI was created...");

			CheckDeviceUICount(1);
		}
	}
}