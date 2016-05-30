Reveal.initialize({
  controls: false,
  progress: true,
  history: true,
  center: true,
  transition: 'slide' // none/fade/slide/convex/concave/zoom
});

Reveal.addEventListener('ready', function(event) {
  Reveal.configure({ center: event.currentSlide.classList.contains("center") })
});
Reveal.addEventListener('slidechanged', function(event) {
  Reveal.configure({ center: event.currentSlide.classList.contains("center") })
});
