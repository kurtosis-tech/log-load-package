def run(plan, num_log_clients=1, logs_per_second=1):
    """Runs services that generate logs at configurable speeds.

    Args:
        num_log_clients(int): The number of log load clients to spin up.
        logs_per_second(int): Rate at which clients generate logs.
    """
    cmd = "--logs-per-second={0}".format(logs_per_second)
    config = ServiceConfig(
        image ="quay.io/openshift-logging/cluster-logging-load-client",
        cmd = [cmd],
        env_vars = {
            "ASSUME_NO_MOVING_GC_UNSAFE_RISK_IT_WITH":"go1.20",
            }
        )

    for num in range(0, num_log_clients):
        plan.add_service(
            name = "log-load-client-{0}".format(num),
            config = config,
        )