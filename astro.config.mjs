import starlight from '@astrojs/starlight';
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: 'Notifycal Docs',
      social: [
        {
          label: 'Github',
          icon: 'github',
          href: 'https://github.com/Notifycal/docs'
        }
      ],
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
          label: 'Analysis',
          autogenerate: { directory: 'analysis' }
        },
        {
          label: 'Reference',
          autogenerate: { directory: 'reference' }
        }
      ]
    })
  ]
});
