module.exports = {
  content: ["./src/main/webapp/**/*.jsp", "./src/main/webapp/**/*.jspf"],
  theme: {
    extend: {
      colors: {
        background: "#f8f9fb",
        primary: "#0a1422",
        "primary-container": "#1f2937",
        "primary-fixed": "#d9e3f6",
        "primary-fixed-dim": "#bdc7d9",
        "secondary": "#0058be",
        "secondary-container": "#2170e4",
        "secondary-fixed": "#d8e2ff",
        surface: "#f8f9fb",
        "surface-bright": "#f8f9fb",
        "surface-container": "#edeef0",
        "surface-container-low": "#f3f4f6",
        "surface-container-lowest": "#ffffff",
        "surface-container-high": "#e7e8ea",
        "surface-container-highest": "#e1e2e4",
        "outline": "#75777c",
        "outline-variant": "#c5c6cc",
        "on-background": "#191c1e",
        "on-surface": "#191c1e",
        "on-surface-variant": "#44474c",
        "on-primary": "#ffffff",
        "on-primary-container": "#8690a1",
        "on-primary-fixed": "#121c2a",
        "on-primary-fixed-variant": "#3d4756",
        "on-secondary": "#ffffff",
        "on-secondary-container": "#fefcff",
        "on-secondary-fixed": "#001a42",
        "on-secondary-fixed-variant": "#004395",
        error: "#ba1a1a",
        "error-container": "#ffdad6",
        "on-error": "#ffffff",
        "on-error-container": "#93000a",
        tertiary: "#00180d",
        "tertiary-fixed": "#6ffbbe",
        "tertiary-fixed-dim": "#4edea3",
        "on-tertiary-fixed-variant": "#005236"
      },
      borderRadius: {
        DEFAULT: "0.25rem",
        lg: "0.5rem",
        xl: "0.75rem",
        full: "9999px"
      },
      spacing: {
        "margin-mobile": "20px",
        "margin-desktop": "40px",
        "gutter-mobile": "16px",
        "gutter-desktop": "32px",
        "container-max": "1280px"
      },
      maxWidth: {
        "container-max": "1280px"
      },
      fontFamily: {
        display: ["Microsoft YaHei", "Arial", "sans-serif"],
        "headline-lg": ["Microsoft YaHei", "Arial", "sans-serif"],
        "headline-md": ["Microsoft YaHei", "Arial", "sans-serif"],
        "body-lg": ["Microsoft YaHei", "Arial", "sans-serif"],
        "body-md": ["Microsoft YaHei", "Arial", "sans-serif"],
        "label-md": ["Microsoft YaHei", "Arial", "sans-serif"],
        "label-sm": ["Microsoft YaHei", "Arial", "sans-serif"]
      },
      fontSize: {
        display: ["48px", { lineHeight: "56px", fontWeight: "700" }],
        "headline-lg": ["32px", { lineHeight: "40px", fontWeight: "600" }],
        "headline-md": ["24px", { lineHeight: "32px", fontWeight: "600" }],
        "body-lg": ["18px", { lineHeight: "28px", fontWeight: "400" }],
        "body-md": ["16px", { lineHeight: "24px", fontWeight: "400" }],
        "label-md": ["14px", { lineHeight: "20px", fontWeight: "500" }],
        "label-sm": ["12px", { lineHeight: "16px", fontWeight: "600" }]
      }
    }
  }
};
