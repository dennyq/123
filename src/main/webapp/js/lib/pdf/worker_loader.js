/* -*- Mode: Java; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/* vim: set shiftwidth=2 tabstop=2 autoindent cindent expandtab: */
/* Copyright 2012 Mozilla Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 /* globals PDFJS, Util */

'use strict';

// List of shared files to include;
var sharedFiles = [
  '/script/pdf/shared/util.js',
  '/script/pdf/shared/colorspace.js',
  '/script/pdf/shared/function.js',
  '/script/pdf/shared/annotation.js'
];

// List of other files to include;
var otherFiles = [
  '/script/pdf/core/network.js',
  '/script/pdf/core/chunked_stream.js',
  '/script/pdf/core/pdf_manager.js',
  '/script/pdf/core/core.js',
  '/script/pdf/core/obj.js',
  '/script/pdf/core/charsets.js',
  '/script/pdf/core/cidmaps.js',
  '/script/pdf/core/crypto.js',
  '/script/pdf/core/pattern.js',
  '/script/pdf/core/evaluator.js',
  '/script/pdf/core/cmap.js',
  '/script/pdf/core/fonts.js',
  '/script/pdf/core/font_renderer.js',
  '/script/pdf/core/glyphlist.js',
  '/script/pdf/core/image.js',
  '/script/pdf/core/metrics.js',
  '/script/pdf/core/parser.js',
  '/script/pdf/core/ps_parser.js',
  '/script/pdf/core/stream.js',
  '/script/pdf/core/worker.js',
  '/script/pdf/core/arithmetic_decoder.js',
  '/script/pdf/core/jpx.js',
  '/script/pdf/core/jbig2.js',
  '/script/pdf/core/bidi.js',
  '/script/pdf/jpgjs/jpg.js'
];

function loadInOrder(index, path, files) {
  if (index >= files.length) {
    PDFJS.fakeWorkerFilesLoadedPromise.resolve();
    return;
  }
  PDFJS.Util.loadScript(path + files[index],
                  loadInOrder.bind(null, ++index, path, files));
}

// Load all the files.
if (typeof PDFJS === 'undefined' || !PDFJS.fakeWorkerFilesLoadedPromise) {
  var files = sharedFiles.concat(otherFiles);
  for (var i = 0; i < files.length; i++) {
    importScripts(files[i]);
  }
} else {
  var src = PDFJS.workerSrc;
  var path = src.substr(0, src.indexOf('worker_loader.js'));
  // If Util is available, we assume that shared files are already loaded. Can
  // happen that they are not if PDF.js is bundled inside a special namespace.
  var skipShared = typeof Util !== 'undefined';
  var files = skipShared ? otherFiles : sharedFiles.concat(otherFiles);
  loadInOrder(0, path, files);
}
