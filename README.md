# flutter temy

## Development

- Optional hook to prevent gradients/shadows
  - We include a simple guard script that fails commits if gradients, shadows, or non-zero elevations are introduced.
  - To enable:
	 1. Point Git hooks to the local hooks directory:
		 ```bash
		 git config core.hooksPath .githooks
		 chmod +x .githooks/pre-commit
		 ```
	 2. You can also run the check manually:
		 ```bash
		 dart tools/check_no_gradients_shadows.dart
		 ```