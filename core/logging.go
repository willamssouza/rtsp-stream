package core

import (
	"os"

	"github.com/sirupsen/logrus"
	"github.com/willamssouza/rtsp-stream/core/config"
)

// SetupLogger sets the logger for the proper settings based on the environment
func SetupLogger(spec *config.Specification) {
	logrus.SetOutput(os.Stdout)
	if spec.Debug {
		logrus.SetLevel(logrus.DebugLevel)
		return
	}
	logrus.SetLevel(logrus.InfoLevel)
}
