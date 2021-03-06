context("Serializer tests")
test_that("redland library loads", {
  library(redland)
  # Add a line to this test to prevent 'Empty test' (skipped) msg.
  expect_true(require(redland))
})
test_that("Serializer constructor", {
  library(redland)
  world <- new("World")
  expect_false(is.null(world))
  
  # Test creating the Storage system
  storage <- new("Storage", world, "hashes", name="", options="hash-type='memory'")
  expect_false(is.null(storage))
  expect_match(class(storage@librdf_storage), "_p_librdf_storage_s")
  
  # Test creating the Model
  model <- new("Model", world, storage, options="")
  expect_false(is.null(model))
  expect_match(class(model@librdf_model), "_p_librdf_model_s")
  
  # Test that model creation fails if world is not provided or is null
  err <- try(model <- new("Model", world=NULL, storage, options=""), silent=TRUE)
  expect_match(class(err), "try-error")
  
  expect_false(is.null(model))
  expect_match(class(model@librdf_model), "_p_librdf_model_s")
  
  # Test adding a Statement to the Model
  subject <- new("Node", world, uri="http://www.johnsmith.com/")
  expect_match(class(subject@librdf_node), "_p_librdf_node_s")
  predicate <- new("Node", world, uri="http://purl.org/dc/elements/1.1/creator")
  expect_match(class(predicate@librdf_node), "_p_librdf_node_s")
  object <- new("Node", world, literal="John Smith", datatype_uri="http://www.w3.org/2001/XMLSchema#string")
  expect_match(class(object@librdf_node), "_p_librdf_node_s")
  statement <- new("Statement", world, subject, predicate, object)
  expect_false(is.null(statement))
  expect_match(class(statement@librdf_statement), "_p_librdf_statement_s")
  addStatement(model, statement)
  
  # Test creating a Serializer
  serializer <- new("Serializer", world, mimeType="application/rdf+xml")
  expect_false(is.null(serializer))
  expect_match(class(serializer@librdf_serializer), "_p_librdf_serializer_s")
  
  # Test adding a namespace to a serializer
  status <- setNameSpace(serializer, world, namespace="http://purl.org/dc/elements/1.1/", prefix="dc")
  expect_that(status, equals(0))
  
  # Test serialization of an RDF model to a string
  rdf <- serializeToCharacter(serializer, world, model, "")
  expect_match(rdf, "John Smith")
  
  # Test serialization of an RDF model to a file
  filePath <- tempfile(pattern = "file", tmpdir = tempdir(), fileext = ".rdf")
  status <- serializeToFile(serializer, world, model, filePath)
  found <- grep("John Smith", readLines(filePath))
  expect_that(found, is_more_than(0))
  unlink(filePath)
  
  err <- try(freeStatement(statement), silent=TRUE)
  expect_false(class(err) == "try-error")
  
  err <- try(freeSerializer(serializer), silent=TRUE)
  expect_false(class(err) ==  "try-error")
  
  err <- try(freeModel(model), silent=TRUE)
  expect_false(class(err) == "try-error")
  
  err <- try(freeStorage(storage), silent=TRUE)
  expect_false(class(err) == "try-error")
  
  err <- try(freeWorld(world), silent=TRUE)
  expect_false(class(err) == "try-error")
  
})