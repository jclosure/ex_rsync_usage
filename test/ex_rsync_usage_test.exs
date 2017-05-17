defmodule ExRsyncUsageTest do
  use ExUnit.Case
  doctest ExRsyncUsage

  setup do

    state = %{
      v1_file: "./test/data/sample1.png",
      v2_file: "./test/data/sample2.png",

      v1_signature_file: "./test/data/sample1.sig",
      v1_to_v2_delta_file: "./test/data/sample2.delta",

      patched_v1_to_v2_file: "./test/data/sample1_patched.png"
    }

    File.rm(state.v1_signature_file)
    File.rm(state.v1_to_v2_delta_file)
    File.rm(state.patched_v1_to_v2_file)

    {:ok, state}
  end

  test "applying a delta produces equivalent versions", state do

    # generate a signature file
    :rsync.sig(state.v1_file, state.v1_signature_file)

    # use the signature to generate a delta
    :rsync.delta(state.v1_signature_file, state.v2_file, state.v1_to_v2_delta_file)

    # apply the delta to produce a patched version
    :rsync.patch(state.v1_file, state.v1_to_v2_delta_file, state.patched_v1_to_v2_file)

    assert File.read!(state.v2_file) == File.read!(state.patched_v1_to_v2_file)
  end

  test "cleanup" do

  end
end
