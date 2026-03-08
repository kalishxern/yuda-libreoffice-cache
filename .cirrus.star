load("github.com/cirrus-modules/graphql", "rerun_task_if_issue_in_logs")

def on_task_failed(ctx):
    # Prevent an infinite loop: if this is already a retried task, do not retry it again.
    if ctx.payload.data.task.automaticReRun:
        print("Task is already an automatic re-run! Won't even try to re-run it...")
        return
    
    # Check the logs of the failed task. If it hit the 2-hour hard limit, 
    # it usually outputs "Time out" or "Timed out". 
    # If it finds this text, it triggers a completely new run.
    rerun_task_if_issue_in_logs(ctx.payload.data.task.id, "Time out")
