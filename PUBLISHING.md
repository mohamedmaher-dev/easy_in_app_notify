# Publishing Instructions

## Before Publishing to pub.dev

### 1. Update Example Dependency

The example currently uses a git dependency from the repository. For publication, you have options:

**Option A: Use Git Dependency (Current):**

```yaml
dependencies:
  easy_in_app_notify:
    git:
      url: https://github.com/mohamedmaher-dev/easy_in_app_notify.git
```

**Option B: Use Pub.dev Version (After Publishing):**

```yaml
dependencies:
  easy_in_app_notify: ^0.0.1
```

**Option C: Use Path (Development Only):**

```yaml
dependencies:
  easy_in_app_notify:
    path: ../
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

- The example now uses git dependency from GitHub repository
- This allows the example to work independently of local development
- All analysis issues have been resolved
- Package validation passes with 0 warnings
- Git dependency is acceptable for publication
