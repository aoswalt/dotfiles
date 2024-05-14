return {
  'kana/vim-textobj-user',
  dependencies = {
    'kana/vim-textobj-entire', -- ae/ie for entire file
    'kana/vim-textobj-indent', -- ai/ii for indent block
    'kana/vim-textobj-line', -- al/il for line
    'sgur/vim-textobj-parameter', -- a,/i, for argument/parameter
    'Julian/vim-textobj-variable-segment', -- av/iv for variable part
    -- 'Chun-Yang/vim-textobj-chunk', -- ac/ic for json-ish chunk
    'whatyouhide/vim-textobj-xmlattr', -- ax/ix for xml attribute
  },
}
