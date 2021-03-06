context('jsonify objects')

test_that('arguments passed to `as.json` pass to `toJSON`', {
  skip_if_not_installed('jsonlite')
  father_time <- Sys.time()
  frame_data <- data.frame(top = c(1:5), bottom = c(10:6), time = rep(father_time, 5))
  expect_equal(jsonlite::toJSON(frame_data), as.json(frame_data))
  expect_equal(jsonlite::toJSON(frame_data, dataframe = 'rows'), as.json(frame_data, dataframe = 'rows'))
  
  frame_list <- list(one = father_time, two = c('blue', 'red', 'blue'))
  expect_equal(jsonlite::toJSON(frame_list, Date = 'epoch'), as.json(frame_list, Date = 'epoch'))
})

test_that('response object content-type is set to application/json if json', {
  skip_if_not_installed('jsonlite')
  res <- response()
  body(res) <- as.json(data.frame(one = 'fish', two = 'fish'))
  expect_true(is.json(body(res)))
  expect_true(is.character(body(res)))
  expect_false(is.data.frame(body(res)))
  expect_true(is.response(res))
  expect_equal(res[['Content-Type']], 'application/json')
  
})

test_that('request object content-type is set to application/json if json', {
  skip('needs reconsidering')
  skip_if_not_installed('jsonlite')
})
