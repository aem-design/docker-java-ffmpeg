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

Multi-architecture support (amd64/arm64).

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

- **Multi-platform builds**: Images are built for both `linux/amd64` and `linux/arm64`
- **Automated testing**: Java and FFMPEG versions are verified before pushing
- **Image analysis**: Uses `dive` for Docker image layer analysis
- **Dual registry push**: Automatically pushes to Docker Hub and GitHub Container Registry
- **Git tag versioning**: Pushing a git tag automatically creates a corresponding Docker image tag

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

