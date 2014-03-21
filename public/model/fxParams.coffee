define [], ()->
  fxParams = {}
  fxParams.fx1 =
  [
    [
      [
        label: "OSC Detune"
        param: "setDetune"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 440]
        step:0.2
      ]
      [
        label: "OSC Volume"
        param: "setVol"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
    ]
    [
      [
        label: "OSC-Amp Frequency"
        param: "setFreqOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0.2, 440]
        step:0.2
      ]
      [
        label: "OSC-Amp Mix"
        param: "setWaveOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
    ]
    [
      [
        label: "OSC-Phase Frequency"
        param: "setFreqOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0.01, 440]
        step:0.01
      ]
      [
        label: "OSC-Phase Mix"
        param: "setMixOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
    ]
  ]

  fxParams.fx2 =
  [
    [
      [
        label: "OSC Detune"
        param: "setDetune"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0.01, 440]
        step:0.2
      ]
      [
        label: "OSC Volume"
        param: "setVol"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
    ]
    [
      [
        label: "OSC-Pitch Frequency"
        param: "setFreqOscPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0.2, 440]
        step:0.2
      ]
      [
        label: "OSC-Pitch Mix"
        param: "setMixOscPitch"
        colorG: "synthParamGroup-C"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
      [
        label: "OSC-Pitch Waveshape"
        param: "setWaveOscPitch"
        colorG: "synthParamGroup-C"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "inveSawtooth"]
      ]
    ]
    [
      [
        label: "OSC-Amp Frequency"
        param: "setFreqOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0.2, 440]
        step:0.2
      ]
      [
        label: "OSC-Amp Mix"
        param: "setWaveOscAmp"
        colorG: "synthParamGroup-B"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
      [
        label: "OSC-Amp Waveshape"
        param: "setWaveOscAmp"
        colorG: "synthParamGroup-B"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "inveSawtooth"]
      ]
    ]
    [
      [
        label: "OSC-Phase Frequency"
        param: "setFreqOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0.01, 440]
        step:0.01
      ]
      [
        label: "OSC-Phase Mix"
        param: "setMixOscPhase"
        colorG: "synthParamGroup-A"
        type: "slider"
        range:[0, 1]
        step:0.01
      ]
      [
        label: "OSC-Phase Waveshape"
        param: "setWaveOscPhase"
        colorG: "synthParamGroup-A"
        type: "button"
        values: ["sine", "square", "pulse", "triangle", "sawtooth", "inveSawtooth"]
      ]
    ]
  ]

  return fxParams