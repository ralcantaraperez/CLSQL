;;;; -*- Mode: LISP; Syntax: ANSI-Common-Lisp; Base: 10 -*-
;;;; *************************************************************************
;;;; FILE IDENTIFICATION
;;;;
;;;; Name:          clsql-base.asd
;;;; Purpose:       ASDF definition file for Base CLSQL
;;;; Programmer:    Kevin M. Rosenberg
;;;; Date Started:  Feb 2002
;;;;
;;;; $Id: clsql-base.asd,v 1.14 2002/09/25 12:44:59 kevin Exp $
;;;;
;;;; This file, part of CLSQL, is Copyright (c) 2002 by Kevin M. Rosenberg
;;;;
;;;; CLSQL users are granted the rights to distribute and use this software
;;;; as governed by the terms of the Lisp Lesser GNU Public License
;;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.
;;;; *************************************************************************

(in-package :asdf)

#+(or allegro lispworks cmu openmcl mcl)
(defsystem :clsql-base
  :name "cl-sql-base"
  :author "Kevin M. Rosenberg <kmr@debian.org>"
  :version "0.9.2"
  :maintainer "Kevin M. Rosenberg <kmr@debian.org>"
  :licence "Lessor Lisp General Public License"
  :description "Common Lisp SQL Base Package"
  :long-description "cl-sql-base package provides the low-level interface for the database drivers."

  :perform (load-op :after (op clsql-base)
		    (pushnew :clsql-base cl:*features*))
  :components
  ((:module :base
	    :components
	    ((:file "cmucl-compat")
	     (:file "package")
	     (:file "utils" :depends-on ("package"))
	     (:file "classes" :depends-on ("package"))
	     (:file "conditions" :depends-on ("classes"))
	     (:file "db-interface" :depends-on ("conditions"))
	     (:file "initialize" :depends-on ("db-interface"))))))

#+(or allegro lispworks cmu openmcl mcl)
(defmethod source-file-type  ((c cl-source-file)
			      (s (eql (find-system :clsql-base)))) 
   "cl")

#+(or allegro lispworks cmu openmcl mcl)
(when (ignore-errors (find-class 'load-compiled-op))
  (defmethod perform :after ((op load-compiled-op) (c (eql (find-system :clsql-base))))
    (pushnew :clsql-base cl:*features*)))
