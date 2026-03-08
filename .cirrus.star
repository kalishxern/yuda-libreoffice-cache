load("github.com/cirrus-modules/graphql", "rerun_task_if_issue_in_logs")

# Required to help Cirrus 'see' the script
def main(ctx):
    return []

def on_task_failed(ctx):
    # Prevent an infinite loop
    if ctx.payload.data.task.automaticReRun:
        print("Task is already an automatic re-run! Won't even try to re-run it...")
        return
    
    # Check the logs and rerun if it timed out
    # Note: This MUST be outside the 'if' block above
    rerun_task_if_issue_in_logs(ctx.payload.data.task.id, "Time out")
