---
title: Tips on documenting your code
---


- If the `show_if_no_docstring` flag is on (default: off) you must put a docstring in a class or it won't get documented

- You can override all of the settings in an `options` block per-file beneath an autodoc instruction (`:::` followed by a
  dotted path to the module/object)

  - One important setting to override is `members` which lets you list the members in the order you want them to appear.
    - Otherwise, they appear in alphabetical order (the `members_order` setting defaults to
      `"rendering.Order.alphabetical.value"`, I prefer changing it to `"source"`).
