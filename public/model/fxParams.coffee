define [], ()->
  fxParams = {}
  fxParams.Delay =
  [
    [
      [
        label: "Time"
        param: "time"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[2, 1000]
        step:0.1
        value: 500
      ]
      [
        label: "Feedback"
        param: "feedback"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 0.99]
        step:0.01
        value: 0.3
      ]
      [
        label: "Mix"
        param: "mix"
        colorG: "synthParamGroup-G"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.66
      ]
    ]
  ]

  fxParams.IIRFilter =
  [
    [
      [
        label: "Cutoff"
        param: "cutoff"
        colorG: "synthParamGroup-F"
        type: "slider"
        range:[0, 8000]
        step: 8
        value: 4000
      ]
      [
        label: "Resonance"
        param: "resonance"
        colorG: "synthParamGroup-F"
        type: "slider"
        range:[0, 0.99]
        step:0.01
        value: 0.3
      ]
      [
        label: "Mix"
        param: "mix"
        colorG: "synthParamGroup-F"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.5
      ]
    ]
  ]

  fxParams.Distortion =
  [
    [
      [
        label: "Mix"
        param: "mix"
        colorG: "synthParamGroup-F"
        type: "slider"
        range:[0, 1]
        step:0.01
        value: 0.5
      ]
    ]
  ]

  return fxParams