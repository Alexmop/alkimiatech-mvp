// brain_regions.js
const brainRegions = [
  {
    id: "frontal",
    name: "Frontal Lobe",
    function: "Executive functions, motor control, language (Broca's area)",
    color: 0xffaa55,
    pos: { x: 0, y: 0.8, z: 1.0 },
  },
  {
    id: "parietal",
    name: "Parietal Lobe",
    function: "Somatic sensations, spatial orientation",
    color: 0x44ff88,
    pos: { x: 0, y: 1.2, z: 0 },
  },
  {
    id: "temporal",
    name: "Temporal Lobe",
    function:
      "Auditory processing, memory (hippocampus), language (Wernicke's area)",
    color: 0x4466ff,
    pos: { x: 1.2, y: 0, z: 0.2 },
  },
  {
    id: "occipital",
    name: "Occipital Lobe",
    function: "Visual processing",
    color: 0xff4466,
    pos: { x: 0, y: 0.2, z: -1.2 },
  },
  {
    id: "cerebellum",
    name: "Cerebellum",
    function: "Motor coordination, balance",
    color: 0x88ff88,
    pos: { x: 0, y: -1.0, z: -0.5 },
  },
  {
    id: "limbic",
    name: "Limbic System (Amygdala/Hippocampus)",
    function: "Emotions, memory formation",
    color: 0xff88ff,
    pos: { x: 0.5, y: -0.2, z: 0.5 },
  },
];

// Make it globally available for the HTML
window.brainRegions = brainRegions;
