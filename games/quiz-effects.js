(function () {
  "use strict";

  function getAudioContext(state) {
    if (state.audioCtx && !state.ctx) state.ctx = state.audioCtx;
    if (!state.ctx) {
      var Ctx = window.AudioContext || window.webkitAudioContext;
      if (Ctx) state.ctx = new Ctx();
    }
    if (state.ctx && !state.audioCtx) state.audioCtx = state.ctx;
    return state.ctx;
  }

  function playPinpon(state) {
    var ctx = getAudioContext(state);
    if (!ctx) return;
    if (ctx.state === "suspended") ctx.resume();
    var t = ctx.currentTime;

    function beep(f, t0, d) {
      var o = ctx.createOscillator();
      var g = ctx.createGain();
      o.type = "sine";
      o.frequency.setValueAtTime(f, t0);
      g.gain.setValueAtTime(0.0001, t0);
      g.gain.exponentialRampToValueAtTime(0.14, t0 + 0.02);
      g.gain.exponentialRampToValueAtTime(0.0001, t0 + d);
      o.connect(g);
      g.connect(ctx.destination);
      o.start(t0);
      o.stop(t0 + d + 0.04);
    }

    beep(784, t, 0.1);
    beep(1046.5, t + 0.11, 0.12);
    beep(1318.51, t + 0.24, 0.2);
  }

  function playBubuu(state) {
    var ctx = getAudioContext(state);
    if (!ctx) return;
    if (ctx.state === "suspended") ctx.resume();
    var t = ctx.currentTime;

    var o1 = ctx.createOscillator();
    var g1 = ctx.createGain();
    o1.type = "sawtooth";
    o1.frequency.setValueAtTime(218, t);
    o1.frequency.exponentialRampToValueAtTime(95, t + 1.05);
    g1.gain.setValueAtTime(0.0001, t);
    g1.gain.exponentialRampToValueAtTime(0.1, t + 0.05);
    g1.gain.setValueAtTime(0.085, t + 0.95);
    g1.gain.exponentialRampToValueAtTime(0.0001, t + 1.35);
    o1.connect(g1);
    g1.connect(ctx.destination);
    o1.start(t);
    o1.stop(t + 1.4);

    var o2 = ctx.createOscillator();
    var g2 = ctx.createGain();
    o2.type = "square";
    o2.frequency.setValueAtTime(108, t);
    o2.frequency.exponentialRampToValueAtTime(70, t + 1.0);
    g2.gain.setValueAtTime(0.0001, t);
    g2.gain.exponentialRampToValueAtTime(0.044, t + 0.06);
    g2.gain.exponentialRampToValueAtTime(0.0001, t + 1.28);
    o2.connect(g2);
    g2.connect(ctx.destination);
    o2.start(t);
    o2.stop(t + 1.32);
  }

  function showOverlay(opts) {
    var overlay = opts.overlay;
    var titleEl = opts.titleEl;
    var subEl = opts.subEl;
    var buzzerEl = opts.buzzerEl;
    var ok = !!opts.ok;
    var onDone = opts.onDone;
    var okClass = opts.okClass || "ok";
    var ngClass = opts.ngClass || "ng";
    var durationMs = opts.durationMs || 1600;

    titleEl.textContent = opts.title || "";
    subEl.textContent = opts.sub || "";
    if (buzzerEl) {
      buzzerEl.classList.toggle("hidden", ok);
      buzzerEl.setAttribute("aria-hidden", ok ? "true" : "false");
    }

    if (opts.beforeShow) opts.beforeShow(ok);
    overlay.classList.toggle(okClass, ok);
    overlay.classList.toggle(ngClass, !ok);
    overlay.classList.add("show");

    window.setTimeout(function () {
      overlay.classList.remove("show");
      overlay.classList.remove(okClass);
      overlay.classList.remove(ngClass);
      if (buzzerEl) buzzerEl.classList.add("hidden");
      if (opts.afterHide) opts.afterHide(ok);
      if (onDone) onDone();
    }, durationMs);
  }

  function burstConfetti(layer, count) {
    if (!layer) return;
    layer.innerHTML = "";
    var n = typeof count === "number" ? count : 24;
    for (var i = 0; i < n; i += 1) {
      var s = document.createElement("span");
      s.className = "confetti-piece";
      s.style.setProperty("--cx", (6 + Math.random() * 88) + "%");
      s.style.setProperty("--ch", String(Math.floor(Math.random() * 360)));
      s.style.setProperty("--cs", (7 + Math.random() * 11) + "px");
      s.style.setProperty("--cdelay", (Math.random() * 0.35).toFixed(2) + "s");
      s.style.setProperty("--cdur", (1.05 + Math.random() * 0.65).toFixed(2) + "s");
      s.style.setProperty("--rot", (420 + Math.floor(Math.random() * 600)) + "deg");
      s.style.setProperty("--dx", (Math.random() * 100 - 50).toFixed(1) + "px");
      layer.appendChild(s);
    }
    layer.classList.remove("hidden");
  }

  window.KidsQuizEffects = {
    playPinpon: playPinpon,
    playBubuu: playBubuu,
    showOverlay: showOverlay,
    burstConfetti: burstConfetti
  };
})();
