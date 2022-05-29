local function setup(args)
  local xplr = xplr

  args = args or {}
  args.copy_command = args.copy_command or "wl-copy"
  args.paste_command = args.paste_command or "wl-paste"
  args.keep_selection = args.keep_selection or false

  xplr.config.modes.custom.wl_copy = {
    name = "wl copy",
    key_bindings = {
      on_key = {
        y = {
          help = "copy files",
          messages = {
            {
              BashExecSilently = [===[
                if cat "${XPLR_PIPE_RESULT_OUT:?}" | ]===] .. args.copy_command .. [===[; then
                  echo LogSuccess: Copied paths to clipboard >> ${XPLR_PIPE_MSG_IN:?}
                else
                  echo LogSuccess: Failed to copy paths >> ${XPLR_PIPE_MSG_IN:?}
                fi
              ]===],
            },
            "PopMode",
          },
        },
        P = {
          help = "copy parent directory",
          messages = {
            {
              BashExecSilently = [===[
              if ]===] .. args.copy_command .. [===[ "${PWD:?}"; then
                echo "LogSuccess: Copied $PWD to clipboard" >> "${XPLR_PIPE_MSG_IN:?}"
              else
                echo "LogError: Failed to copy $PWD" >> "${XPLR_PIPE_MSG_IN:?}"
              fi
              ]===],
            },
            "PopMode",
          },
        },
        esc = {
          help = "cancel",
          messages = {
            "PopMode",
          },
        },
        ["ctrl-c"] = {
          messages = {
            "Terminate",
          },
        },
      },
    },
  }

  if not args.keep_selection then
    table.insert(
      xplr.config.modes.custom.wl_copy.key_bindings.on_key.y.messages,
      "ClearSelection"
    )
    table.insert(
      xplr.config.modes.custom.wl_copy.key_bindings.on_key.P.messages,
      "ClearSelection"
    )
  end

  xplr.config.modes.builtin.default.key_bindings.on_key.y = {
    help = "copy to clipboard",
    messages = {
      "PopMode",
      { SwitchModeCustom = "wl_copy" },
    },
  }

  xplr.config.modes.builtin.default.key_bindings.on_key.p = {
    help = "paste from clipboard",
    messages = {
      {
        BashExec = args.paste_command .. [===[ | while read -r path; do
            [ -e "$path" ] && cp -var "${path:?}" ./
          done
          read -p "[press ENTER to continue]"
        ]===],
      },
      "ExplorePwd",
      "PopMode",
    },
  }
end

return { setup = setup }
