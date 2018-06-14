﻿using System;
using NUnit.Framework;

namespace GreenSense.Index.Tests.Integration
{
	[TestFixture(Category = "Integration")]
	public class CreateMonitorEspTestFixture : BaseTestFixture
	{
		[Test]
		public void Test_CreateMonitorEspScript()
		{
			var scriptName = "test-monitor-esp";

			Console.WriteLine("Script:");
			Console.WriteLine(scriptName);

			var starter = GetDockerProcessStarter();
			starter.PreCommand = "sh init-mock-setup.sh";
			var output = starter.RunScript(scriptName);

			var successfulText = "Monitor ESP8266 test complete";

			Assert.IsTrue(output.Contains(successfulText), "Failed");
		}
	}
}
