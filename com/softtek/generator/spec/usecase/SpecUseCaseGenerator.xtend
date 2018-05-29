package com.softtek.generator.spec.usecase

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.softtek.uc.ucs.Entity
import com.softtek.uc.ucs.UIContainer
import com.softtek.uc.ucs.Task
import com.softtek.uc.ucs.Module
import com.softtek.uc.ucs.SystemStep
import com.softtek.uc.ucs.ActorStep
import com.softtek.uc.ucs.SystemShowsStep
import com.softtek.uc.ucs.SystemValidatesFormStep
import com.softtek.uc.ucs.SystemFillsListStep
import com.softtek.uc.ucs.SystemCreatesEntityStep
import com.softtek.uc.ucs.SystemUpdatesEntityStep
import com.softtek.uc.ucs.SystemDeletesEntityStep
import com.softtek.uc.ucs.SystemInvokesUCStep
import com.softtek.uc.ucs.ActorEntersStep
import com.softtek.uc.ucs.ActorChoosesStep
import com.softtek.uc.ucs.ActorSelectsStep

class SpecUseCaseGenerator {
	def doGenerate(Resource resource, IFileSystemAccess2 fsa) {
		for (m : resource.allContents.toIterable.filter(typeof(Module))) {
			fsa.generateFile("use-cases/"+m.name+".tex", m.generateModule)
		}
	}
	
	def CharSequence generateModule(Module m) '''
		\section{Modulo: «m.module_name»}
		
		«FOR e : m.elements»
			«e.genModuleElement»
		«ENDFOR»
	'''
	
	def dispatch genModuleElement(Entity e) '''
	'''
	
	def dispatch genModuleElement(UIContainer c) '''
	'''
	
	def dispatch genModuleElement(Task task) '''
	\subsection{«task.uc_id». «task.uc_name»} \label{«task.name»}
	\textbf{Actores}: «task.trigger.actor.name»
	
	\textbf{Objetivo}: «task.uc_goal».
	
	\textbf{Evento Disparador}: «task.trigger.actor.name» solicita la página \textit{[«task.trigger.page.page_title»]}.
	
	\textbf{Tipo}: Usuario\\
	
	\textbf{Escenario Principal}
	
	\begin{enumerate}
	«FOR s : task.steps»
		\item «s.genUCStep»
	«ENDFOR»
	\item Fin del Caso de Uso.
	\end{enumerate}
	'''
	
	
	def dispatch genUCStep(SystemStep s) '''
		«s.genUCSystemStep»
	'''
	
	def dispatch genUCSystemStep(SystemShowsStep s) '''
		El Sistema muestra la página \textit{[«s.page.page_title»]}.
	'''
	
	def dispatch genUCSystemStep(SystemValidatesFormStep s) '''
		El Sistema valida que los datos de la forma \textit{[«s.form.form_title»]} estan completos.
			\begin{enumerate}
				\item Excepción: Datos incompletos.
			\end{enumerate}
	'''
	
	def dispatch genUCSystemStep(SystemFillsListStep s) '''
		El Sistema obtiene información y muestra la lista \textit{[«s.list.list_title»]}.
	'''
	
	def dispatch genUCSystemStep(SystemCreatesEntityStep s) '''
		El Sistema crea un nuevo registro en la entidad \textit{[«s.entity.name»]}.
	'''
	
	def dispatch genUCSystemStep(SystemUpdatesEntityStep s) '''
		El Sistema actuliza la información de la entidad \textit{[«s.entity.name»]}.
	'''
	
	def dispatch genUCSystemStep(SystemDeletesEntityStep s) '''
		El Sistema elimina el registro de la entidad \textit{[«s.entity.name»]}.
	'''

	def dispatch genUCSystemStep(SystemInvokesUCStep s) '''
		El Sistema invoca al Caso de Uso \textit{[«s.usecase.uc_id». «s.usecase.uc_name»]}.
	'''	
	
	
	
	def dispatch genUCStep(ActorStep a) '''
		«a.genUCActorStep»
	'''
	
	def dispatch genUCActorStep(ActorEntersStep s) '''
		«s.actor.name» captura información en la forma \textit{[«s.form.form_title»]}.
	'''

	def dispatch genUCActorStep(ActorChoosesStep s) '''
		«s.actor.name» elige el comando \textit{[«s.command.command_label»]}.
	'''

	def dispatch genUCActorStep(ActorSelectsStep s) '''
		«s.actor.name» selecciona el comando \textit{[«s.list.command_label»]}.
	'''
}

