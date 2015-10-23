path = require 'path'

describe 'Command Modifier: Change Project', ->
  ed = null
  s = null

  beforeEach ->
    jasmine.attachToDOM(atom.views.getView(atom.workspace))
    atom.project.addPath(s = path.join(atom.project.getPaths()[0], 'sub0'))
    p = atom.workspace.open(path.join(s, 'test.txt')).then (e) -> ed = e
    waitsForPromise -> p

  it 'correctly determines the project folder', ->
    c = {}
    r = require('../lib/build-tools-change-project').provideModifier().mod.preSplit(c)
    expect(r).toBeUndefined()
    expect(c.project).toBe s
