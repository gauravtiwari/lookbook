import morph from "morphdom";

export default function (from, to, opts = {}) {
  morph(from, to, {
    onBeforeElUpdated: function (fromEl, toEl) {
      if (fromEl._x_dataStack) {
        Alpine.clone(fromEl, toEl);
      }
      if (fromEl.isEqualNode(toEl) || fromEl.hasAttribute("skip-morph")) {
        return false;
      }
      return true;
    },
    ...opts,
  });
}
