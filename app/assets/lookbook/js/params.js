import debounce from "debounce";

export default function paramsEditor() {
  const debouncedUpdate = debounce(updateSearchParams, 250);
  return {
    updateUrl($event) {
      debouncedUpdate($event.target.name, $event.target.value, () => {
        this.$dispatch("refresh");
      });
    },
  };
}

function updateSearchParams(key, value, done) {
  const { search, protocol, host, pathname } = window.location;
  const searchParams = new URLSearchParams(search);
  searchParams.set(key, encodeURIComponent(JSON.stringify(value)));
  const url = `${protocol}//${host}${pathname}?${searchParams.toString()}`;
  window.history.replaceState({ path: url }, "", url);
  done();
}
