defmodule GlobalTest do
  use ExUnit.Case, async: true

  test "#del_lock/1" do
    :global.set_lock({:del_lock_1, :del_lock_1_test})
    assert true = Global.del_lock({:del_lock_1, :del_lock_1_test})
  end

  test "#del_lock/2" do
    :global.set_lock({:del_lock_1, :del_lock_1_test}, [node()])
    assert true = Global.del_lock({:del_lock_1, :del_lock_1_test}, [node()])
  end

  test "#notify_all/3" do
    pid1 = spawn fn -> assert_receive {:global_name_conflict, :notify_all, other_pid} end
    pid2 = spawn fn -> assert_receive {:global_name_conflict, :notify_all, other_pid} end
    Global.notify_all(:notify_all, pid1, pid2)
  end

  test "#random_exit/3" do
    pid1 = spawn fn -> :timer.sleep(:infinity) end
    pid2 = spawn fn -> :timer.sleep(:infinity) end
    assert Global.random_exit(:random_exit, pid1, pid2) in [pid1, pid2]
  end

  test "#random_notify/3" do
    pid1 = spawn fn ->
      receive do
        _ -> nil
      end
    end
    pid2 = spawn fn ->
      receive do
        _ -> nil
      end
    end
    Global.random_notify(:random_notify, pid1, pid2)
    :timer.sleep(100)
    assert Process.alive?(pid1) != Process.alive?(pid2)
  end

  test "#register/2" do
    pid = spawn fn -> :timer.sleep(:infinity) end
    assert Global.register(pid, :register_2) == :yes
  end

  test "#register/3" do
    pid = spawn fn -> :timer.sleep(:infinity) end
    assert Global.register(pid, :register_3, &Global.random_exit/3) == :yes
  end

  test "#registered/0" do
    pid = spawn fn -> :timer.sleep(:infinity) end
    :global.register_name(:registered_0, pid)
    assert :registered_0 in Global.registered
  end

  test "#re_register/2" do
    pid = spawn fn -> :timer.sleep(:infinity) end
    assert Global.re_register(pid, :re_register_2) == :yes
  end

  test "#re_register/3" do
    pid = spawn fn -> :timer.sleep(:infinity) end
    assert Global.re_register(pid, :re_register_3, &Global.random_exit/3) == :yes
  end

  test "#send/2" do
    pid = spawn fn ->
      receive do
        :message -> nil
      end
    end
    :global.register_name(:send_2, pid)
    assert Global.send(:send_2, :message) == pid
    :timer.sleep(100)
    refute Process.alive?(pid)
  end

  test "#set_lock/1" do
    assert Global.set_lock({:set_lock_1, :set_lock_1_test})
  end

  test "#set_lock/2" do
    assert Global.set_lock({:set_lock_2, :set_lock_2_test}, [node()])
  end

  test "#set_lock/3" do
    assert Global.set_lock({:set_lock_3, :set_lock_3_test}, [node()], :infinity)
  end

  test "#sync/0" do
    assert Global.sync == :ok
  end

  test "#trans/2" do
    assert Global.trans({:trans_2, :trans_2_test}, fn -> end) == nil
  end

  test "#trans/3" do
    assert Global.trans({:trans_2, :trans_2_test}, [node()], fn -> end) == nil
  end

  test "#trans/4" do
    assert Global.trans({:trans_2, :trans_2_test}, [node()], :infinity, fn -> end) == nil
  end

  test "#unregister/1" do
    :global.register_name(:unregister, self)
    assert Global.unregister(:unregister) == :ok
  end

  test "#whereis/1" do
    :global.register_name(:whereis, self)
    assert Global.whereis(:whereis) == self
    assert Global.whereis(:nothing) == nil
  end

end
