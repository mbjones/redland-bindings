% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Node.R
\docType{methods}
\encoding{UTF-8}
\name{getNodeValue}
\alias{getNodeValue}
\alias{getNodeValue,Node-method}
\title{Get the value of the node as a string}
\usage{
getNodeValue(.Object)

\S4method{getNodeValue}{Node}(.Object)
}
\arguments{
\item{.Object}{a Node object}
}
\value{
a string representation of the Node's value
}
\description{
Get the value of the node as a string
}
\details{
The value of the node is returned as a string. If the node type is
'blank', then the blank node identifier is returned. If the node type is
'literal', then the literal value is returned with the form "<value>"@<language>,
e.g. "¡Hola, amigo! ¿Cómo estás?"@es". If the node type is 'uri'
then the value is returned as a string.
}
\examples{
world <- new("World")
node <- new("Node", world, literal="¡Hola, amigo! ¿Cómo estás?", language="es")
value <- getNodeValue(node)
}
