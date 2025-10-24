## Java with FFMPEG

[![build](https://github.com/aem-design/docker-java-ffmpeg/actions/workflows/build.yml/badge.svg?branch=jdk17)](https://github.com/aem-design/docker-java-ffmpeg/actions/workflows/build.yml)
[![github license](https://img.shields.io/github/license/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github issues](https://img.shields.io/github/issues/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github last commit](https://img.shields.io/github/last-commit/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![github repo size](https://img.shields.io/github/repo-size/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg) 
[![docker stars](https://img.shields.io/docker/stars/aemdesign/java-ffmpeg)](https://hub.docker.com/r/aemdesign/java-ffmpeg) 
[![docker pulls](https://img.shields.io/docker/pulls/aemdesign/java-ffmpeg)](https://hub.docker.com/r/aemdesign/java-ffmpeg) 
[![github release](https://img.shields.io/github/release/aem-design/java-ffmpeg)](https://github.com/aem-design/java-ffmpeg)

Docker image based on [aemdesign/oracle-jdk](https://hub.docker.com/r/aemdesign/oracle-jdk/) with FFMPEG and media processing libraries.

Docker image for linux/amd64 (also runs on Apple Silicon via Rosetta 2).

## Docker Images

Images are available on both registries:
- **Docker Hub**: `aemdesign/java-ffmpeg`
- **GitHub Container Registry**: `ghcr.io/aem-design/java-ffmpeg`

### Tags

- `latest` - Latest build from main branch
- `jdk17` - JDK 17 branch
- Version tags (pushed when git tags are created)

### Included Packages

* **imagemagick** - Image conversion and processing
* **libx** - X11 libraries for forms processing
* **ffmpeg** - Video and audio processing
* **buildtools** - Build utilities for media libraries
* **xvid** - Video codec library

## Development

### CI/CD Pipeline

The project uses GitHub Actions for continuous integration and deployment:

- **Platform**: Images are built for `linux/amd64`
- **Apple Silicon support**: Works seamlessly on M1/M2/M3/M4 Macs via Docker Desktop's Rosetta 2 emulation
- **Automated testing**: Java and FFMPEG versions are verified before pushing
- **Image analysis**: Uses `dive` for Docker image layer analysis
- **Dual registry push**: Automatically pushes to Docker Hub and GitHub Container Registry
- **Git tag versioning**: Pushing a git tag automatically creates a corresponding Docker image tag

### Running on Apple Silicon Macs (M1/M2/M3/M4)

This image is built for `linux/amd64` architecture but runs seamlessly on Apple Silicon Macs through **Rosetta 2** emulation in Docker Desktop.

#### Prerequisites

1. **Docker Desktop for Mac** (version 4.25.0 or later recommended)
   - Download from: https://www.docker.com/products/docker-desktop

2. **Rosetta 2** (usually already installed on modern macOS)
   - To verify/install: `softwareupdate --install-rosetta`

#### Enable Rosetta 2 in Docker Desktop

1. Open **Docker Desktop**
2. Go to **Settings** (⚙️ icon) → **General**
3. Enable **"Use Rosetta for x86_64/amd64 emulation on Apple Silicon"**
4. Click **Apply & Restart**

![Docker Desktop Rosetta Setting](https://docs.docker.com/desktop/images/rosetta.png)

#### Verify It's Working

```bash
# Pull and run the image
docker pull aemdesign/java-ffmpeg:latest
docker run --rm aemdesign/java-ffmpeg:latest uname -m

# Expected output: x86_64 (running via Rosetta 2)
```

#### Performance Notes

- **Rosetta 2 emulation** provides near-native performance for most workloads
- First container start may be slightly slower (Rosetta translation cache warmup)
- Subsequent starts are fast
- **No code changes needed** - everything works transparently

### Monitoring Pipeline Status

Use the `get-action-logs.ps1` PowerShell script to monitor GitHub Actions workflow status and logs.

#### Prerequisites

- GitHub CLI (`gh`) must be installed and authenticated
- Install: `winget install --id GitHub.cli`
- Authenticate: `gh auth login`

#### Quick Start

```powershell
# Check current commit's pipeline status (saves logs to logs/ folder by default)
.\get-action-logs.ps1

# Wait for pipeline to complete
.\get-action-logs.ps1 -WaitForCompletion

# Show logs in console
.\get-action-logs.ps1 -ShowLogs

# Force re-download logs
.\get-action-logs.ps1 -Force
```

See full documentation: `Get-Help .\get-action-logs.ps1 -Full`

### Creating a New Release

```bash
# Tag the commit
git tag 1.0.0
git push origin 1.0.0
```

This will automatically build and push versioned Docker images to both registries.

## License

See [LICENSE](LICENSE) file for details.

