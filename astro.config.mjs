import starlight from '@astrojs/starlight';
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: 'Notifycal Docs',
      social: {
        github: 'https://github.com/Notifycal/docs'
      },
      sidebar: [
        {
          label: 'Guides',
          autogenerate: { directory: 'guides' }
          // items: [
          // 	// Each item here is one entry in the navigation menu.
          // 	{ label: 'Example Guide', link: '/guides/example/' },
          // ],
        },
        {
          label: 'Reference',
          autogenerate: { directory: 'reference' }
        },
        {
          label: 'Analysis',
          autogenerate: { directory: 'analysis' }
        }
      ]
    })
  ]
});
