// OSX reminders app handler
var remindersApp = Application("Reminders");
remindersApp.includeStandardAdditions = true;

// this object will support task data for two apps
var macRemindersData = {}
var todoistData = {};	

var getTodoistToken = function(){
	var app = Application.currentApplication();
	app.includeStandardAdditions=true;

	return app.doShellScript('cat ~/Applications/todoist_osx_sync/token')
}

// load Todoist data from remote API
var getTodoistData = function(){
	var token = getTodoistToken()
	var app = Application.currentApplication();
	app.includeStandardAdditions=true;
	todoistData = JSON.parse(app.doShellScript('curl "https://todoist.com/API/v6/sync?token=' + token + '&seq_no=0&resource_types=\\[\\"projects\\",\\"items\\",\\"labels\\"\\]"'));
	

}

// WIP
var saveSyncData = function(){
	var app = Application.currentApplication();
	app.includeStandardAdditions=true;

	app.doShellScript('echo "'+ JSON.stringify(macRemindersData).replace('&','\\&') +'" > ~/Applications/todoist_osx_sync/sync.dat')
}

// load OSX Reminders
var getMacRemindersData = function(){
	macRemindersData.ProjectsById = {}
	macRemindersData.ProjectsByName = {}
	macRemindersData.taskByProjectAndName = {}
	
	for (i=0;i<remindersApp.lists.length;i++){
		var list = remindersApp.lists[i];	
		macRemindersData.ProjectsById[list.id()] = list
		macRemindersData.ProjectsByName[list.name()] = list

		macRemindersData.taskByProjectAndName[list.name()] = {}
		for (j=0;j<list.reminders.length;j++){
			var reminder = list.reminders[j];
			macRemindersData.taskByProjectAndName[list.name()][reminder.name()]= reminder
		};
	}	
}

// load OSX Reminders List
var getMacProjects = function(){
	var macProjects = {}
	for (i=0;i<remindersApp.lists.length;i++){
		macProjects[remindersApp.lists[i].name()] = remindersApp.lists[i]
	}
	return macProjects;
}

// load OSX Reminders
var getMacReminders = function(){

	for (i=0;i<remindersApp.lists.length;i++){
		var list = remindersApp.lists[i];
		macReminders[list.id()] = {
			name: list.name(),
			tasks: {}
		};
		for (j=0;j<list.reminders.length;j++){
			var reminder = list.reminders[j];
			macReminders[list.id()].tasks[reminder.id()] = {
				name: reminder.name(),
				completed: reminder.completed()
			}
		};
	}
}

// create a OSX Task List given input data
var createMacProject = function(name){
	
	var newProject = remindersApp.make({
		new: "list",
		withProperties: {
			name: name
		}	
	});
	
	macRemindersData.ProjectsById[newProject.id()] = newProject
	macRemindersData.ProjectsByName[newProject.name()] = newProject

	macRemindersData.taskByProjectAndName[newProject.name()] = {}	
	
}

// create a OSX Reminder given input data
var createMacReminder = function(taskList, name, body, dueDate, priority, remindMeDate){

	var props = {
		name: name
	}	
	
	if (body != null || body != undefined)
		props.body = body

	if (dueDate != null || dueDate != undefined)
		props.dueDate = dueDate		

	if (priority != null || priority != undefined)
		props.priority = priority
		
	if (remindMeDate != null || remindMeDate != undefined)
		props.remindMeDate = remindMeDate
		
	console.log(props)	
		
	var newReminder = taskList.make({
		new: "reminder",
		at: taskList,
		withProperties: props	
	});
	
	return newReminder
	
}

// convert Todoist task label id array to label name string
var taskLabelsToString = function(labels){
	//console.log(JSON.stringify(todoistData.Labels))
	labelsTxt=undefined
	labels.forEach(function(labelId,index){
		labelObj = todoistData.Labels.find(function(labelObj_){
			return labelObj_.id == labelId
		})
		if (labelObj != null && labelObj != undefined)
			if (labelsTxt == undefined)
				labelsTxt = '@'+labelObj.name
			else
				labelsTxt = labelsTxt + " @" + labelObj.name
			
	})
	return labelsTxt
}

// loop Todoist task and create them in OSX Reminders
var syncProjectTasks = function(projectName){
		
	todoistTasks = todoistData.Items.filter(function(task){
		return task.project_id == todoistData.ProjectsByName[projectName].id
	}).sort(function(task1,task2){
		return(task1.item_order - task2.item_order)
	})
	
	todoistTasks.forEach(function(task,index){
		var isCompleted = task.checked || task.in_history
		
		if (task.indent > 0)
			task.content = Array(task.indent).join("▶ ") + task.content
			
		if (!isCompleted){	
			macTask = macRemindersData.taskByProjectAndName[projectName][task.content]
			if(!macTask){
				// task date could be null
				if (task.due_date_utc != null && task.due_date_utc != undefined)
					taskDate = new Date(task.due_date_utc)
				else
					taskDate = undefined
				newMacReminder = createMacReminder(macRemindersData.ProjectsByName[projectName], task.content, taskLabelsToString(task.labels), taskDate )
			}
	
		}
	})
}

// Loop Todoist projects and create them as OSX Reminders List
var syncProjects = function(){
	todoistProjects = todoistData.Projects;
	macProjects = macRemindersData.ProjectsByName;
	
	todoistProjects.sort(function(pro1, pro2){
		return(pro1.item_order - pro2.item_order)			
	})
	todoistData.ProjectsById = {}
	todoistData.ProjectsByName = {}	
	
	todoistProjects.forEach(function(project,index){
		todoistData.ProjectsById[project.id] = project
		if (project.indent > 0)
			project.name = Array(project.indent).join("▶ ") + project.name
		todoistData.ProjectsByName[project.name] = project	
			
		if (project.is_deleted == 0 && Object.keys(macProjects).indexOf(project.name) == -1){
			createMacProject(project.name)
		}
		
		syncProjectTasks(project.name)
	})	

}


// main entry point

getTodoistData()
getMacRemindersData()
syncProjects()
//saveSyncData()


