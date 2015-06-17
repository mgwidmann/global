defmodule Global do

  # Simple delegations

  @doc """
  Deletes the lock `id` synchronously.
  """
  @spec del_lock(:global.id) :: true
  defdelegate del_lock(id),                         to: :global

  @doc """
  Deletes the lock `id` synchronously.
  """
  @spec del_lock(:global.id, [atom]) :: true
  defdelegate del_lock(id, nodes),                  to: :global

  @doc """
  This function can be used as a name resolving function for `register/3` and `re_register/3`.
  It unregisters both pids, and sends the message `{:global_name_conflict, name, other_pid}`
  to both processes.
  """
  @spec notify_all(atom, pid, pid) :: pid
  defdelegate notify_all(name, pid1, pid2),         to: :global, as: :notify_all_name

  @doc """
  This function can be used as a name resolving function for `register/3` and `re_register/3`.
  It randomly chooses one of the pids for registration and kills the other one.
  """
  @spec random_exit(atom, pid, pid) :: pid
  defdelegate random_exit(name, pid1, pid2),        to: :global, as: :random_exit_name

  @doc """
  This function can be used as a name resolving function for `register/3` and
  `re_register/3`. It randomly chooses one of the pids for registration, and sends
  the message `{:global_name_conflict, name}` to the other pid.
  """
  @spec random_notify(atom, pid, pid) :: pid
  defdelegate random_notify(name, pid1, pid2),      to: :global, as: :random_notify_name

  @doc """
  Returns a lists of all globally registered names.
  """
  @spec registered() :: [atom]
  # Provide same API as `Process`
  defdelegate registered(),                         to: :global, as: :registered_names


  @doc """
  Sends the message `msg` to the pid globally registered as `name`.

  Failure: If `name` is not a globally registered name, the calling function will
  exit with reason `{:badarg, {name, msg}}`.
  """
  @spec send(any, any) :: pid
  defdelegate send(name, msg),                      to: :global

  @doc """
  Sets a lock on the specified nodes (or on all nodes if none are specified) on
  `resource_id` for `lock_requester_id` (see `:global.id` typespec). If a lock
  already exists on `resource_id` for another requester than `lock_requester_id`,
  and `retries` is not equal to 0, the process sleeps for a while and will try to
  execute the action later. When `retries` attempts have been made, `false` is
  returned, otherwise `true`. If `retries` is `:infinity`, `true` is eventually
  returned (unless the lock is never released).

  If no value for `retries` is given, `:infinity` is used.

  This function is completely synchronous.

  If a process which holds a lock dies, or the node goes down, the locks held by
  the process are deleted.

  The global name server keeps track of all processes sharing the same lock, that is,
  if two processes set the same lock, both processes must delete the lock.

  This function does not address the problem of a deadlock. A deadlock can never
  occur as long as processes only lock one resource at a time. But if some processes
  try to lock two or more resources, a deadlock may occur. It is up to the application
  to detect and rectify a deadlock.

  ## NOTE

  Some values of `resource_id` should be avoided or Erlang/OTP will not work properly.
  A list of resources to avoid: `:global`, `:dist_ac`, `:mnesia_table_lock`, `:mnesia_adjust_log_writes`,
  `:pg2`.
  """
  @spec set_lock(:global.id) :: true | false
  defdelegate set_lock(id),                         to: :global

  @doc """
  Sets a lock on the specified nodes (or on all nodes if none are specified) on
  `resource_id` for `lock_requester_id` (see `:global.id` typespec). If a lock
  already exists on `resource_id` for another requester than `lock_requester_id`,
  and `retries` is not equal to 0, the process sleeps for a while and will try to
  execute the action later. When `retries` attempts have been made, `false` is
  returned, otherwise `true`. If `retries` is `:infinity`, `true` is eventually
  returned (unless the lock is never released).

  If no value for `retries` is given, `:infinity` is used.

  This function is completely synchronous.

  If a process which holds a lock dies, or the node goes down, the locks held by
  the process are deleted.

  The global name server keeps track of all processes sharing the same lock, that is,
  if two processes set the same lock, both processes must delete the lock.

  This function does not address the problem of a deadlock. A deadlock can never
  occur as long as processes only lock one resource at a time. But if some processes
  try to lock two or more resources, a deadlock may occur. It is up to the application
  to detect and rectify a deadlock.

  ## NOTE

  Some values of `resource_id` should be avoided or Erlang/OTP will not work properly.
  A list of resources to avoid: `:global`, `:dist_ac`, `:mnesia_table_lock`, `:mnesia_adjust_log_writes`,
  `:pg2`.
  """
  @spec set_lock(:global.id, [atom]) :: true | false
  defdelegate set_lock(id, nodes),                  to: :global

  @doc """
  Sets a lock on the specified nodes (or on all nodes if none are specified) on
  `resource_id` for `lock_requester_id` (see `:global.id` typespec). If a lock
  already exists on `resource_id` for another requester than `lock_requester_id`,
  and `retries` is not equal to 0, the process sleeps for a while and will try to
  execute the action later. When `retries` attempts have been made, `false` is
  returned, otherwise `true`. If `retries` is `:infinity`, `true` is eventually
  returned (unless the lock is never released).

  If no value for `retries` is given, `:infinity` is used.

  This function is completely synchronous.

  If a process which holds a lock dies, or the node goes down, the locks held by
  the process are deleted.

  The global name server keeps track of all processes sharing the same lock, that is,
  if two processes set the same lock, both processes must delete the lock.

  This function does not address the problem of a deadlock. A deadlock can never
  occur as long as processes only lock one resource at a time. But if some processes
  try to lock two or more resources, a deadlock may occur. It is up to the application
  to detect and rectify a deadlock.

  ## NOTE

  Some values of `resource_id` should be avoided or Erlang/OTP will not work properly.
  A list of resources to avoid: `:global`, `:dist_ac`, `:mnesia_table_lock`, `:mnesia_adjust_log_writes`,
  `:pg2`.
  """
  @spec set_lock(:global.id, [atom], integer | :infinity) :: true | false
  defdelegate set_lock(id, nodes, retries),         to: :global

  @doc """
  Synchronizes the global name server with all nodes known to this node. These are
  the nodes which are returned from `:erlang.nodes()`. When this function returns,
  the global name server will receive global information from all nodes. This function
  can be called when new nodes are added to the network.
  """
  @spec sync() :: :ok | {:error, any}
  defdelegate sync(),                               to: :global

  @doc """
  Removes the globally registered name `name` from the network of Erlang nodes.
  """
  @spec unregister(atom) :: :ok
  defdelegate unregister(name),                     to: :global, as: :unregister_name

  # API changes

  @doc """
  Sets a lock on `id` (using `set_lock/3`). If this succeeds, `fun.()` is evaluated
  and the result `res` is returned. Returns `:aborted` if the lock attempt failed.
  If Retries is set to `:infinity`, the transaction will not abort.

  `:infinity` is the default setting and will be used if no value is given for `retries`.
  """
  @spec trans(:global.id, [atom], integer | :infinity) :: any | :aborted
  def trans(id, nodes \\ Node.list, retries \\ :infinity, fun) do
    :global.trans(id, fun, nodes, retries)
  end

  @doc """
  Atomically changes the registered name `name` on all nodes to refer to `pid`.

  The `resolve` function has the same behavior as in `register_name/2,3`.
  """
  # Provide same API as `Process.register`
  @spec re_register(pid, atom, ((atom, pid, pid) -> pid)) :: :yes | :no
  def re_register(pid, name, resolve \\ &__MODULE__.random_exit/3) do
    :global.re_register_name(name, pid, resolve)
  end

  @doc """
  Globally associates the name `name` with a pid, that is, Globally notifies all
  nodes of a new global name in a network of Erlang nodes.

  When new nodes are added to the network, they are informed of the globally registered
  names that already exist. The network is also informed of any global names in
  newly connected nodes. If any name clashes are discovered, the `resolve` function
  is called. Its purpose is to decide which pid is correct. If the function crashes,
  or returns anything other than one of the pids, the name is unregistered. This
  function is called once for each name clash.

  ### WARNING

  *If you plan to change code without restarting your system, you must use an external
  function (&Module.function/arity from anoter module) as the resolve function; if
  you use a local function you can never replace the code for the module that the
  function belongs to.*

  There are three pre-defined resolve functions: `random_exit/3`, `random_notify/3`,
  and `notify_all/3`. If no `resolve` function is defined, `random_exit/3` is
  used. This means that one of the two registered processes will be selected as
  correct while the other is killed.

  This function is completely synchronous. This means that when this function returns,
  the name is either registered on all nodes or none.

  The function returns `:yes` if successful, `:no` if it fails. For example, `:no`
  is returned if an attempt is made to register an already registered process or
  to register a process with a name that is already in use.

  If a process with a registered name dies, or the node goes down, the name is
  unregistered on all nodes.
  """
  # Provide same API as `Process`
  @spec register(pid, atom, ((atom, pid, pid) -> pid)) :: :yes | :no
  def register(pid, name, resolve \\ &__MODULE__.random_exit/3) do
    :global.register_name(name, pid, resolve)
  end

  @doc """
  Returns the pid with the globally registered name `name`. Returns `nil` if the
  name is not globally registered.
  """
  # Provide same API as `Process`
  @spec whereis(atom) :: pid | port | nil
  def whereis(name) do
    case :global.whereis_name(name) do
      pid when is_pid(pid)  -> pid
      :undefined            -> nil
    end
  end

end
