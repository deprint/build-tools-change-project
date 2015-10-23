module.exports = BuildToolsChangeProject =

  provideModifier: ->
    key: 'cdatom'
    mod:
      name: 'Change Project Folder'
      description: 'Execute command relative to closest Atom project folder'
      private: false

      edit:
        class CdAtomSaver
          get: (command) ->
            command.modifier.cdatom = {}
            return null

      preSplit: (command) ->
        return 'No active text editor' unless (p = atom.workspace.getActiveTextEditor()?.getPath())?
        best = null
        for {realPath} in atom.project.getDirectories()
          if p.startsWith(realPath) and (realPath.length > (best?.length ? null))
            best = realPath
        if best?
          command.project = best
          return
        return 'Could not determine project folder for ' + p
