# Publishing Instructions

## Before Publishing to pub.dev

### 1. Update Example Dependency

The example currently uses a path dependency for development. Before publishing, you need to:

1. Change the example dependency in `example/pubspec.yaml`:
   ```yaml
   dependencies:
     easy_in_app_notify: ^0.0.1  # Use version instead of path
   ```

2. After publishing to pub.dev, you can change it back to path for development:
   ```yaml
   dependencies:
     easy_in_app_notify:
       path: ../  # For development
   ```

### 2. Publishing Steps

1. **Final Check:**
   ```bash
   flutter analyze
   flutter pub publish --dry-run
   ```

2. **Publish:**
   ```bash
   flutter pub publish
   ```

### 3. Post-Publication

1. Update example dependency back to path for future development
2. Create GitHub release with changelog
3. Update repository description

## Notes

- The example uses path dependency during development
- Change to version dependency only for publication
- All analysis issues have been resolved
- Package validation passes with 0 warnings
