package com.softtek.generator.ui

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.IFileSystemAccess2
import com.softtek.uc.ucs.Module
import com.softtek.uc.ucs.Entity
import com.softtek.uc.ucs.Task
import com.softtek.uc.ucs.PageContainer
import com.softtek.uc.ucs.FormComponent
import com.softtek.uc.ucs.ListComponent

class IUPrototypeGenerator {
	def doGenerate(Resource resource, IFileSystemAccess2 fsa) {
		for (m : resource.allContents.toIterable.filter(typeof(Module))) {
			
			m.genImportTags(fsa)
			
			for (e : m.elements) {
				e.genModuleElement(m, fsa)
			}
		}
	}
	
	def CharSequence genImportTags(Module m, IFileSystemAccess2 fsa) '''
		«fsa.generateFile('''ui-prototype/partials/import_«m.name.toLowerCase»_tags.js''', m.generateImportModuleTags)»
		«fsa.generateFile('''ui-prototype/partials/route_«m.name.toLowerCase».txt''', m.generateRouteModule)»
		«fsa.generateFile('''ui-prototype/partials/screenshoots_«m.name.toLowerCase»_url.txt''', m.generateScreenshotsModule)»
	'''
	
	def CharSequence generateScreenshotsModule(Module m) '''
		// Urls for: «m.name»
		URLS = URLS.concat([
		«FOR p : m.elements»
			«p.generateScreenshotsUrls(m)»
		«ENDFOR»
		])
	'''

	def dispatch generateScreenshotsUrls(Entity element, Module m) '''
	'''
	def dispatch generateScreenshotsUrls(Task element, Module m) '''
	'''
	def dispatch generateScreenshotsUrls(PageContainer p, Module m) '''
		{page: 'http://localhost:1337/#!/«p.name.toLowerCase»/', title: '«p.name»', module: '«m.name»'},
	'''
	
	def CharSequence generateImportModuleTags(Module m) '''
		«FOR p : m.elements»
			«p.genImportPageTags(m)»
		«ENDFOR»
	'''
	
	def dispatch genImportPageTags(Entity element, Module m) '''
	'''
	def dispatch genImportPageTags(Task element, Module m) '''
	'''
	def dispatch genImportPageTags(PageContainer p, Module m) '''
		import './components/app/«m.name.toLowerCase»/«p.name.toLowerCase».tag'
	'''
	

	def CharSequence generateRouteModule(Module m) '''
		«FOR p : m.elements»
			«p.genRoutes(m)»
		«ENDFOR»	
	'''
	
	def dispatch genRoutes(Entity element, Module m) '''
	'''
	def dispatch genRoutes(Task element, Module m) '''
	'''
	def dispatch genRoutes(PageContainer p, Module m) '''
		{ route: '/«p.name.toLowerCase»/', tag: '«p.name.toLowerCase»' },
	'''


	def dispatch genModuleElement(Entity e, Module m, IFileSystemAccess2 fsa) '''
	'''
	def dispatch genModuleElement(Task t, Module m, IFileSystemAccess2 fsa) '''
	'''	
	def dispatch genModuleElement(PageContainer p, Module m, IFileSystemAccess2 fsa) '''
		«fsa.generateFile('''ui-prototype/tags/«m.name.toLowerCase»/«p.name.toLowerCase».tag''', p.generateTag)»
	'''

	
	def CharSequence generateTag(PageContainer p) '''
	<«p.name.toLowerCase»>
		<page id="«p.name.toLowerCase»" title="«p.page_title»">
			«FOR c : p.components»
				«IF c instanceof FormComponent»
					«c.genFormComponent»
				«ENDIF»
				«IF c instanceof ListComponent»
					«c.genListComponent(p)»
				«ENDIF»
			«ENDFOR»
			«FOR b : p.commands»
				<submit-button to="/«b.link_to.name.toLowerCase»/" action="custom" icon="«b.icon»" caption="«b.command_label»" ></submit-button>
			«ENDFOR»
		</page>
	</«p.name.toLowerCase»>
	'''
	
	def CharSequence genListComponent(ListComponent l, PageContainer p) '''
    <table-results id="«p.name.toLowerCase»-«l.name.toLowerCase»" title="«l.list_title»">
    </table-results>
	'''
	
	def CharSequence genFormComponent(FormComponent f) '''
	<formbox title="«f.form_title»">
		<div class="ln_solid"></div>
		«FOR c : f.commands»
			<submit-button to="/«c.link_to.name»/" action="custom" icon="«c.icon»" caption="«c.command_label»" ></submit-button>
		«ENDFOR»
	</formbox>
	'''
	
	def static toLowerCase(String it){
	  toLowerCase
	}
}