# Isotope Extensions

$.Isotope::_getCenteredMasonryColumns = ->
  @width = @element.width()
  parentWidth = @element.parent().width()
  colW = @options.masonry and @options.masonry.columnWidth or @$filteredAtoms.outerWidth(true) or parentWidth
  cols = Math.floor(parentWidth / colW)
  cols = Math.max(cols, 1)
  @masonry.cols = cols
  @masonry.columnWidth = colW

$.Isotope::_getModifiedMasonryColumns = ->
  gutter = @options.masonry and @options.masonry.gutterWidth or 0
  @width = @element.width()
  parentWidth = @element.parent().width()
  colW = @options.masonry and @options.masonry.columnWidth or @$filteredAtoms.outerWidth(true) or parentWidth
  colW += gutter
  cols = Math.floor(parentWidth / colW)
  cols = Math.max(cols, 1)
  @masonry.cols = cols
  @masonry.columnWidth = colW

$.Isotope::_getMasonryGutterColumns = ->
  gutter = @options.masonry and @options.masonry.gutterWidth or 0
  containerWidth = @element.width()
  @masonry.columnWidth = @options.masonry and @options.masonry.columnWidth or @$filteredAtoms.outerWidth(true) or containerWidth
  @masonry.columnWidth += gutter
  @masonry.cols = Math.floor((containerWidth + gutter) / @masonry.columnWidth)
  @masonry.cols = Math.max(@masonry.cols, 1)

$.Isotope::_masonryReset = ->
  @masonry = {}
  @_getModifiedMasonryColumns()
  i = @masonry.cols
  @masonry.colYs = []
  @masonry.colYs.push 0  while i--

$.Isotope::_masonryResizeChanged = ->
  prevColCount = @masonry.cols
  @_getModifiedMasonryColumns()
  @masonry.cols isnt prevColCount

$.Isotope::_masonryGetContainerSize = ->
  gutter = @options.masonry and @options.masonry.gutterWidth or 0
  unusedCols = 0
  i = @masonry.cols
  while --i
    break  if @masonry.colYs[i] isnt 0
    unusedCols++
  height: Math.max.apply(Math, @masonry.colYs)
  width: ((@masonry.cols - unusedCols) * @masonry.columnWidth) - gutter