﻿using System;
using NUnit.Framework;

namespace GrowSense.Index.Tests.Integration
{
    [TestFixture (Category = "Integration")]
    public class CreateIlluminatorUnoTestFixture : BaseTestFixture
    {
        [Test]
        public void Test_CreateIlluminatorUnoScript ()
        {
            var scriptName = "create-garden-illuminator-uno.sh";

            Console.WriteLine ("Script:");
            Console.WriteLine (scriptName);

            var deviceBoard = "uno";
            var deviceGroup = "illuminator";
            var deviceProject = "LightPRSensorCalibratedLight";
            var deviceLabel = "MyIlluminator";
            var deviceName = "myIlluminator";
            var devicePort = "ttyUSB1";

            var arguments = deviceLabel + " " + deviceName + " " + devicePort;

            var starter = GetTestProcessStarter ();
            starter.RunBash ("sh " + scriptName + " " + arguments);

            CheckDeviceInfoWasCreated (deviceBoard, deviceGroup, deviceProject, deviceLabel, deviceName, devicePort);

            // Disabled because the UI is created by the supervisor script now
            //CheckDeviceUIWasCreated (deviceLabel, deviceName, "Light", "L");

            CheckMqttBridgeServiceFileWasCreated (deviceName);
        }
    }
}
