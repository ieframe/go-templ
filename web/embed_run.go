//go:build run

package web

import (
	"io/fs"
	"os"
)

var Static fs.FS = os.DirFS("web")
